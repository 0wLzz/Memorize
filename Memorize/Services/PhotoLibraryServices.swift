//
//  PhotoLibraryService.swift
//  Memorize
//
//  Created by Hans Hartowidjojo on 16/07/26.
//

import Foundation
import Photos
import UIKit

protocol PhotoLibraryServicing {
    func requestAuthorization() async -> PhotoLibraryService.AuthorizationResult
    func fetchAllAssetIdentifiers() -> [String]
    func resolveImage(for identifier: String, targetSize: CGSize) async -> UIImage?
}

final class PhotoLibraryService {

    enum AuthorizationResult {
        case authorized
        case limited
        case denied
        case restricted
        case notDetermined
    }

    func requestAuthorization() async -> AuthorizationResult {
        let status = await PHPhotoLibrary.requestAuthorization(for: .readWrite)
        switch status {
        case .authorized:
            return .authorized
        case .limited:
            return .limited
        case .denied:
            return .denied
        case .restricted:
            return .restricted
        case .notDetermined:
            return .notDetermined
        @unknown default:
            return .denied
        }
    }

    /// Fetches all photo assets from the user's library, newest first.
    /// Returns their localIdentifiers — the only thing PersonModel needs to store.
    func fetchAllAssetIdentifiers() -> [String] {
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

        let result = PHAsset.fetchAssets(with: .image, options: options)

        var identifiers: [String] = []
        result.enumerateObjects { asset, _, _ in
            identifiers.append(asset.localIdentifier)
        }
        return identifiers
    }

    /// Resolves a stored localIdentifier back into a displayable UIImage.
    /// Returns nil if the asset no longer exists (e.g. deleted from the library).
    func resolveImage(for identifier: String, targetSize: CGSize = CGSize(width: 300, height: 300)) async -> UIImage? {
        let fetchResult = PHAsset.fetchAssets(withLocalIdentifiers: [identifier], options: nil)
        guard let asset = fetchResult.firstObject else { return nil }

        return await withCheckedContinuation { continuation in
            let options = PHImageRequestOptions()
            options.deliveryMode = .highQualityFormat
            options.isSynchronous = false
            options.isNetworkAccessAllowed = true // in case it's an iCloud-only asset

            PHImageManager.default().requestImage(
                for: asset,
                targetSize: targetSize,
                contentMode: .aspectFill,
                options: options
            ) { image, _ in
                continuation.resume(returning: image)
            }
        }
    }
}

extension PhotoLibraryService: PhotoLibraryServicing { }
