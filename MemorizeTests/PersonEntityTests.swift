//
//  PersonEntityTests.swift
//  Memorize
//
//  Created by Hans Hartowidjojo on 16/07/26.
//

import XCTest
@testable import Memorize

final class PersonEntityTests: XCTestCase {
    func testRoundTrip() {
        let p = PersonModel(id: UUID(), name: "Test", contacts: ContactsModel())
        let entity = PersonEntity(from: p)
        let roundTrip = entity.toModel()
        XCTAssertEqual(roundTrip.name, p.name)
    }
}
