//
//  PersonRepository.swift
//  Memorize
//
//  Created by Hans Hartowidjojo on 16/07/26.
//  The only layer allowed to touch SwiftData persistence for PersonModel.
//

import Foundation
import SwiftData

@Observable
final class PersonRepository {
    private var context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func fetchAll() -> [PersonModel] {
        let descriptor = FetchDescriptor<PersonEntity>(sortBy: [SortDescriptor(\.name)])
        do {
            let entities = try context.fetch(descriptor)
            return entities.map { $0.toModel() }
        } catch {
            print("Failed to fetch persons: \(error)")
            return []
        }
    }

    func add(_ person: PersonModel) {
        let entity = PersonEntity(from: person)
        context.insert(entity)
        save()
    }

    func delete(_ person: PersonModel) {
        let descriptor = FetchDescriptor<PersonEntity>(
            predicate: #Predicate { $0.id == person.id }
        )
        if let entity = try? context.fetch(descriptor).first {
            context.delete(entity)
            save()
        }
    }

    func update(_ person: PersonModel) {
        let descriptor = FetchDescriptor<PersonEntity>(
            predicate: #Predicate { $0.id == person.id }
        )
        guard let entity = try? context.fetch(descriptor).first else { return }
        entity.name = person.name
        entity.notes = person.notes
        entity.contactsData = (try? JSONEncoder().encode(person.contacts)) ?? Data()
        entity.birthdayData = try? JSONEncoder().encode(person.birthday)
        entity.profileImageIdentifier = person.profileImageIdentifier
        entity.linkedAssetIdentifiers = person.linkedAssetIdentifiers
        entity.faceEmbedding = person.faceEmbedding
        entity.isFavorite = person.isFavorite
        save()
    }

    private func save() {
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}
