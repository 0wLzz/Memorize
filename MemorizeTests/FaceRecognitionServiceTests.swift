//
//  FaceRecognitionServiceTests.swift
//  Memorize
//
//  Created by Hans Hartowidjojo on 16/07/26.
//

import XCTest
@testable import Memorize

final class FaceRecognitionServiceTests: XCTestCase {

    func testGenerateEmbedding() async throws {
        let service = FaceRecognitionService()
        let image = try loadTestImage("person1_photo1")

        let embedding = await service.generateEmbedding(from: image)

        XCTAssertNotNil(embedding, "Expected a face to be detected and an embedding generated")
        XCTAssertEqual(embedding?.count, 512, "FaceNet embeddings should be 512-dimensional")
    }

    func testSamePersonSimilarity() async throws {
        let service = FaceRecognitionService()
        let imageA = try loadTestImage("person1_photo1")
        let imageB = try loadTestImage("person1_photo2")
        let imageC = try loadTestImage("person2_photo1")

        guard let embeddingA = await service.generateEmbedding(from: imageA),
              let embeddingB = await service.generateEmbedding(from: imageB),
              let embeddingC = await service.generateEmbedding(from: imageC) else {
            XCTFail("Failed to generate one or more embeddings")
            return
        }

        let similarityAB = cosineSimilarity(embeddingA, embeddingB)
        let similarityAC = cosineSimilarity(embeddingA, embeddingC)

        print("Same person similarity:", similarityAB)
        print("Different person similarity:", similarityAC)

        XCTAssertGreaterThan(similarityAB, similarityAC, "Same-person similarity should be higher than different-person similarity")
    }

    // MARK: - Helpers

    private func loadTestImage(_ name: String, extension ext: String = "jpeg") throws -> UIImage {
        guard let url = Bundle(for: type(of: self)).url(forResource: name, withExtension: ext),
              let data = try? Data(contentsOf: url),
              let image = UIImage(data: data) else {
            XCTFail("Missing \(name).\(ext) in test bundle")
            throw NSError(domain: "FaceRecognitionServiceTests", code: 0)
        }
        return image
    }

    private func cosineSimilarity(_ a: [Float], _ b: [Float]) -> Float {
        let dot = zip(a, b).map(*).reduce(0, +)
        let normA = sqrt(a.map { $0 * $0 }.reduce(0, +))
        let normB = sqrt(b.map { $0 * $0 }.reduce(0, +))
        return dot / (normA * normB)
    }
}
