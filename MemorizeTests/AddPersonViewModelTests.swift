//
//  AddPersonViewModelTests.swift
//  Memorize
//
//  Created by Hans Hartowidjojo on 17/07/26.
//

import XCTest
import SwiftData
@testable import Memorize

final class AddPersonViewModelTests: XCTestCase {

    func testInitializesWithoutCrashing() throws {
        // Arrange: real dependencies, same pattern as your other repo tests
        let container = try ModelContainer(for: PersonEntity.self,
                                            configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let context = ModelContext(container)
        let repository = PersonRepository(context: context)
        let photoService = PhotoLibraryService()

        // Act
        let viewModel = AddPersonViewModel(photoLibraryService: photoService, personRepository: repository)

        // Assert: just confirm initial state is what we expect
        XCTAssertTrue(viewModel.availableAssetIdentifiers.isEmpty)
        XCTAssertNil(viewModel.resolvedImage)
        XCTAssertNil(viewModel.errorMessage)
    }
}
