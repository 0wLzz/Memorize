//
//  PhotoLibraryServices.swift
//  Memorize
//
//  Created by Hans Hartowidjojo on 16/07/26.
//

import XCTest
import Photos
@testable import Memorize

final class PhotoLibraryServiceTests: XCTestCase {

    func testFetchAndResolve() async throws {
        let service = PhotoLibraryService()

        let authResult = await service.requestAuthorization()
        // In CI/first-run this might be .notDetermined until manually approved once;
        // for a local Simulator run after granting access, expect .authorized or .limited.
        XCTAssertTrue(authResult == .authorized || authResult == .limited, "Photo library access not granted — grant access in Simulator Settings first")

        let identifiers = service.fetchAllAssetIdentifiers()
        XCTAssertFalse(identifiers.isEmpty, "Expected at least one photo in the Simulator's library")

        guard let firstID = identifiers.first else { return }
        let image = await service.resolveImage(for: firstID)
        XCTAssertNotNil(image, "Expected to resolve an image for a valid identifier")
    }
}
