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
}
