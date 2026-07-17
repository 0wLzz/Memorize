//
//  testLoadAssetIdentifiersPopulatesState.swift
//  Memorize
//
//  Created by Hans Hartowidjojo on 17/07/26.
//

import XCTest
import SwiftData // needed to use ModelContainer and ModelConfiguration
@testable import Memorize

func testLoadAssetIdentifiersPopulatesState() throws {
    let fakePhotoService = FakePhotoLibraryService()
    fakePhotoService.stubbedIdentifiers = ["id-1", "id-2", "id-3"]

    let container = try ModelContainer(for: PersonEntity.self,
                                        configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    let repository = PersonRepository(context: ModelContext(container))
    let viewModel = AddPersonViewModel(photoLibraryService: fakePhotoService, personRepository: repository)

    viewModel.loadAssetIdentifiers()

    XCTAssertEqual(viewModel.availableAssetIdentifiers, ["id-1", "id-2", "id-3"])
}

func testResolveImagePopulatesState() async throws {
    let fakePhotoService = FakePhotoLibraryService()
    fakePhotoService.stubbedImage = UIImage(systemName: "photo") // any non-nil UIImage works

    let container = try ModelContainer(for: PersonEntity.self,
                                        configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    let repository = PersonRepository(context: ModelContext(container))
    let viewModel = AddPersonViewModel(photoLibraryService: fakePhotoService, personRepository: repository)

    await viewModel.resolveImage(for: "some-id")

    XCTAssertNotNil(viewModel.resolvedImage)
}
