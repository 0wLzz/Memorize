//
//  PersonMatchingViewModelTests.swift
//  Memorize
//
//  Created by Hans Hartowidjojo on 20/07/26.
//  Memorize
//

import XCTest
@testable import Memorize

final class PersonMatchingViewModelTests: XCTestCase {

    func testInitializesWithoutCrashing() {
        let vm = PersonMatchingViewModel(
            personRepository: FakePersonRepository(),
            faceRecognitionService: FakeFaceRecognitionService()
        )
        XCTAssertNil(vm.matchResult)
        XCTAssertNil(vm.matchScore)
        XCTAssertFalse(vm.isMatching)
    }
    
    func testFindBestMatch_returnsClosestPerson() {
        let vm = PersonMatchingViewModel(
            personRepository: FakePersonRepository(),
            faceRecognitionService: FakeFaceRecognitionService()
        )

        let target: [Float] = [1, 0, 0]
        let personA = makePerson(name: "A", embedding: [0.9, 0.1, 0])   // close
        let personB = makePerson(name: "B", embedding: [0, 1, 0])       // far
        let personC = makePerson(name: "C", embedding: nil)             // no embedding, must be skipped

        let result = vm.findBestMatch(for: target, among: [personA, personB, personC])

        XCTAssertEqual(result.person?.name, "A")
        XCTAssertGreaterThan(result.score, 0.9)
    }

    func testFindBestMatch_noPeopleHaveEmbeddings_returnsNil() {
        let vm = PersonMatchingViewModel(
            personRepository: FakePersonRepository(),
            faceRecognitionService: FakeFaceRecognitionService()
        )

        let personA = makePerson(name: "A", embedding: nil)
        let result = vm.findBestMatch(for: [1, 0, 0], among: [personA])

        XCTAssertNil(result.person)
    }

    // Helper — check if you already have a similar builder in your test target;
    // if PersonModel's initializer differs, adjust fields accordingly.
    private func makePerson(name: String, embedding: [Float]?) -> PersonModel {
        PersonModel(
            id: UUID(),
            name: name,
            contacts: ContactsModel(),
            faceEmbedding: embedding
        )
    }
}


