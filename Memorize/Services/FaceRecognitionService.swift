//
//  FaceRecognitionServices.swift
//  Memorize
//
//  Created by Hans Hartowidjojo on 16/07/26.
//  Wraps Vision (face detection) + a bundled FaceNet CoreML model (embedding).
//  No comparison/matching logic here — that belongs in a ViewModel.
//

import Foundation
import UIKit
import Vision
import CoreML

final class FaceRecognitionService {

    private let facenet: Facenet6
    private let inputSize = 160

    init() {
        do {
            let config = MLModelConfiguration()
            self.facenet = try Facenet6(configuration: config)
        } catch {
            fatalError("Failed to load Facenet6 model: \(error)")
        }
    }

    /// Detects a face in the given image and returns its 512-float embedding.
    /// Returns nil if no face is found or the model fails.
    func generateEmbedding(from image: UIImage) async -> [Float]? {
        guard let croppedFace = await detectAndCropFace(in: image) else {
            print("❌ crop stage failed")
            return nil
        }
        guard let resized = resize(croppedFace, to: inputSize) else {
            print("❌ resize stage failed")
            return nil
        }
        guard let inputArray = try? preprocess(resized) else {
            print("❌ preprocess stage failed")
            return nil
        }
        guard let prediction = try? facenet.prediction(input: inputArray) else {
            print("❌ prediction stage failed")
            return nil
        }
        return arrayFromMultiArray(prediction.embeddings)
    }

    // MARK: - Vision face detection

    /// Downscales large images before running Vision on them — full-resolution
    /// photos (e.g. 4284x5712) are unnecessary for detection and can cause
    /// Vision requests to be cancelled in constrained environments.
    private func downscaledForDetection(_ image: UIImage, maxDimension: CGFloat = 1024) -> UIImage {
        let size = image.size
        let scale = min(maxDimension / size.width, maxDimension / size.height, 1.0)
        guard scale < 1.0 else { return image }
        let newSize = CGSize(width: size.width * scale, height: size.height * scale)
        UIGraphicsBeginImageContextWithOptions(newSize, false, image.scale)
        image.draw(in: CGRect(origin: .zero, size: newSize))
        let scaled = UIGraphicsGetImageFromCurrentImageContext() ?? image
        UIGraphicsEndImageContext()
        return scaled
    }

    /// Normalizes the image's pixel buffer to match its display orientation,
    /// so bounding-box math and raw buffer coordinates agree.
    private func normalizedUpright(_ image: UIImage) -> UIImage {
        guard image.imageOrientation != .up else { return image }
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        image.draw(in: CGRect(origin: .zero, size: image.size))
        let normalized = UIGraphicsGetImageFromCurrentImageContext() ?? image
        UIGraphicsEndImageContext()
        return normalized
    }

    private func detectAndCropFace(in image: UIImage) async -> UIImage? {
        let preparedImage = normalizedUpright(downscaledForDetection(image))
        guard let cgImage = preparedImage.cgImage else {
            print("❌ no cgImage")
            return nil
        }

        return await withCheckedContinuation { continuation in
            let request = VNDetectFaceRectanglesRequest { request, error in
                if let error = error {
                    print("❌ Vision error: \(error)")
                }
                guard let results = request.results as? [VNFaceObservation],
                      let face = results.first else {
                    print("❌ no face observations")
                    continuation.resume(returning: nil)
                    return
                }
                print("✅ face found: \(face.boundingBox)")

                let width = CGFloat(cgImage.width)
                let height = CGFloat(cgImage.height)
                let rect = CGRect(
                    x: face.boundingBox.origin.x * width,
                    y: (1 - face.boundingBox.origin.y - face.boundingBox.height) * height,
                    width: face.boundingBox.width * width,
                    height: face.boundingBox.height * height
                )

                guard let cropped = cgImage.cropping(to: rect) else {
                    print("❌ crop rect out of bounds: \(rect), image size: \(width)x\(height)")
                    continuation.resume(returning: nil)
                    return
                }
                continuation.resume(returning: UIImage(cgImage: cropped))
            }
            request.usesCPUOnly = true // avoid GPU/Metal cancellation issues in test runners

            // Image is already normalized to .up, so orientation is always .up here.
            let handler = VNImageRequestHandler(cgImage: cgImage, orientation: .up, options: [:])
            try? handler.perform([request])
        }
    }

    // MARK: - Preprocessing (resize, strip alpha, prewhiten)

    private func resize(_ image: UIImage, to size: Int) -> UIImage? {
        let targetSize = CGSize(width: size, height: size)
        UIGraphicsBeginImageContextWithOptions(targetSize, true, 1.0)
        image.draw(in: CGRect(origin: .zero, size: targetSize))
        let resized = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resized
    }

    private func preprocess(_ image: UIImage) throws -> MLMultiArray {
        let width = inputSize
        let height = inputSize
        let dataSize = width * height * 4
        var pixelData = [UInt8](repeating: 0, count: dataSize)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(
            data: &pixelData,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: 4 * width,
            space: colorSpace,
            bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue
        )
        guard let cgImage = image.cgImage else {
            throw ServiceError.invalidImage
        }
        context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))

        // Strip alpha channel — RGBA (4 bytes/pixel) -> RGB (3 values/pixel)
        var rgbValues = [Double](repeating: 0, count: width * height * 3)
        var rgbIndex = 0
        for i in stride(from: 0, to: pixelData.count, by: 4) {
            rgbValues[rgbIndex] = Double(pixelData[i])
            rgbValues[rgbIndex + 1] = Double(pixelData[i + 1])
            rgbValues[rgbIndex + 2] = Double(pixelData[i + 2])
            rgbIndex += 3
        }

        // Prewhiten (per-image normalization expected by FaceNet)
        let mean = rgbValues.reduce(0, +) / Double(rgbValues.count)
        var sumSquares = 0.0
        for i in 0..<rgbValues.count {
            rgbValues[i] -= mean
            sumSquares += pow(rgbValues[i], 2)
        }
        let std = sqrt(sumSquares / Double(rgbValues.count))
        let stdAdj = max(std, 1.0 / sqrt(Double(rgbValues.count)))

        let inputArray = try MLMultiArray(
            shape: [1, NSNumber(value: height), NSNumber(value: width), 3],
            dataType: .float32
        )
        for (i, value) in rgbValues.enumerated() {
            inputArray[i] = NSNumber(value: Float32(value / stdAdj))
        }
        return inputArray
    }

    private func arrayFromMultiArray(_ multiArray: MLMultiArray) -> [Float] {
        var result = [Float](repeating: 0, count: multiArray.count)
        for i in 0..<multiArray.count {
            result[i] = multiArray[i].floatValue
        }
        return result
    }

    enum ServiceError: Error {
        case invalidImage
    }
}
