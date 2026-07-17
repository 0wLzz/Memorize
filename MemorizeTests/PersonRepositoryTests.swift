//
//  PersonRepositoryTests.swift
//  Memorize
//
//  Created by Hans Hartowidjojo on 16/07/26.
//

import XCTest
import SwiftData
@testable import Memorize

final class PersonRepositoryTests: XCTestCase {
    @MainActor
    func testAddAndFetch() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: PersonEntity.self, configurations: config)
        let repo = PersonRepository(context: container.mainContext)

        let person = PersonModel(id: UUID(), name: "Test Person", contacts: ContactsModel())
        repo.add(person)

        let all = repo.fetchAll()
        XCTAssertEqual(all.count, 1)
        XCTAssertEqual(all.first?.name, "Test Person")
    }
}
