//
//  PersonRepository.swift
//  Memorize
//
//  Created by Hans Hartowidjojo on 16/07/26.
//  SwiftData persistence entity — mirrors PersonModel.
//  Only PersonRepository should ever touch this type directly.
//

import Foundation
import SwiftData

@Model
final class PersonEntity {
    @Attribute(.unique) var id: UUID
    var name: String
    var notes: String?

    // ContactsModel and BirthdayModel are plain Codable structs (no @Model),
    // so we store them as encoded Data and decode on the way out.
    var contactsData: Data
    var birthdayData: Data?

    var profileImageIdentifier: String?
    var linkedAssetIdentifiers: [String]
    var faceEmbedding: [Float]?
    var isFavorite: Bool

    init(from model: PersonModel) {
        self.id = model.id
        self.name = model.name
        self.notes = model.notes
        self.contactsData = (try? JSONEncoder().encode(model.contacts)) ?? Data()
        self.birthdayData = try? JSONEncoder().encode(model.birthday)
        self.profileImageIdentifier = model.profileImageIdentifier
        self.linkedAssetIdentifiers = model.linkedAssetIdentifiers
        self.faceEmbedding = model.faceEmbedding
        self.isFavorite = model.isFavorite
    }

    func toModel() -> PersonModel {
        let contacts = (try? JSONDecoder().decode(ContactsModel.self, from: contactsData)) ?? ContactsModel()
        let birthday = birthdayData.flatMap { try? JSONDecoder().decode(BirthdayModel.self, from: $0) }
        return PersonModel(
            id: id,
            name: name,
            notes: notes,
            contacts: contacts,
            birthday: birthday,
            profileImageIdentifier: profileImageIdentifier,
            linkedAssetIdentifiers: linkedAssetIdentifiers,
            faceEmbedding: faceEmbedding,
            isFavorite: isFavorite
        )
    }
}
