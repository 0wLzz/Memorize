//
//  FakePersonRepository.swift
//  Memorize
//
//  Created by Hans Hartowidjojo on 17/07/26.
//


import Foundation
@testable import Memorize

final class FakePersonRepository: PersonRepositoryProtocol {
    var storedPersons: [PersonModel] = []
    var updateCallCount = 0

    func fetchAll() -> [PersonModel] {
        storedPersons
    }

    func add(_ person: PersonModel) {
        storedPersons.append(person)
    }

    func delete(_ person: PersonModel) {
        storedPersons.removeAll { $0.id == person.id }
    }

    func update(_ person: PersonModel) {
        updateCallCount += 1
        if let index = storedPersons.firstIndex(where: { $0.id == person.id }) {
            storedPersons[index] = person
        }
    }
}