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
    
    func testLoadAssetIdentifiersPopulatesState() throws {
        print("start", Date())
        let fakePhotoService = FakePhotoLibraryService()
        fakePhotoService.stubbedIdentifiers = ["id-1", "id-2", "id-3"]
        print("before fake repo", Date())

        let fakeRepository = FakePersonRepository()
        let viewModel = AddPersonViewModel(photoLibraryService: fakePhotoService, personRepository: fakeRepository)
        print("before loadAssetIdentifiers", Date())

        viewModel.loadAssetIdentifiers()
        print("after loadAssetIdentifiers", Date())

        XCTAssertEqual(viewModel.availableAssetIdentifiers, ["id-1", "id-2", "id-3"])
        print("end", Date())
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
    
    func testTagAssetAppendsIdentifierAndSaves() throws {
        let fakePhotoService = FakePhotoLibraryService()
        let fakeRepository = FakePersonRepository()

        let person = PersonModel(id: UUID(), name: "Test Person", contacts: ContactsModel())
        fakeRepository.storedPersons = [person]

        let viewModel = AddPersonViewModel(photoLibraryService: fakePhotoService, personRepository: fakeRepository)

        viewModel.tagAsset("new-asset-id", to: person)

        XCTAssertEqual(fakeRepository.updateCallCount, 1)
        XCTAssertEqual(fakeRepository.storedPersons.first?.linkedAssetIdentifiers, ["new-asset-id"])
    }
    
    func testEndToEndFetchResolveTagSaveReload() async throws {
        // Arrange
        let fakePhotoService = FakePhotoLibraryService()
        fakePhotoService.stubbedIdentifiers = ["asset-1", "asset-2"]
        fakePhotoService.stubbedImage = UIImage(systemName: "photo")

        let fakeRepository = FakePersonRepository()
        let person = PersonModel(id: UUID(), name: "End To End Person", contacts: ContactsModel())
        fakeRepository.storedPersons = [person]

        let viewModel = AddPersonViewModel(photoLibraryService: fakePhotoService, personRepository: fakeRepository)

        // Act: fetch
        viewModel.loadAssetIdentifiers()
        XCTAssertEqual(viewModel.availableAssetIdentifiers, ["asset-1", "asset-2"])

        // Act: resolve the first fetched identifier
        let identifierToTag = try XCTUnwrap(viewModel.availableAssetIdentifiers.first)
        await viewModel.resolveImage(for: identifierToTag)
        XCTAssertNotNil(viewModel.resolvedImage)

        // Act: tag + save
        viewModel.tagAsset(identifierToTag, to: person)

        // Assert: reload from repository, confirm identifier persisted
        let reloadedPerson = try XCTUnwrap(fakeRepository.fetchAll().first { $0.id == person.id })
        XCTAssertTrue(reloadedPerson.linkedAssetIdentifiers.contains(identifierToTag))
    }
    
}
