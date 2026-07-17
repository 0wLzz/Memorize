//
//  FakePhotoLibraryService.swift
//  Memorize
//
//  Created by Hans Hartowidjojo on 17/07/26.
//
import UIKit
@testable import Memorize

final class FakePhotoLibraryService: PhotoLibraryServicing {
    var stubbedIdentifiers: [String] = []

    func requestAuthorization() async -> PhotoLibraryService.AuthorizationResult {
        .authorized
    }

    func fetchAllAssetIdentifiers() -> [String] {
        stubbedIdentifiers
    }

    func resolveImage(for identifier: String, targetSize: CGSize) async -> UIImage? {
        nil
    }
}
