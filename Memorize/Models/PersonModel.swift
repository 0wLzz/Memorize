//
//  PersonModel.swift
//  Memorize
//
//  Created by Hans Hartowidjojo on 16/07/26.
//

import Foundation

struct PersonModel: Identifiable, Codable {
    var id: UUID
    var name: String
    var notes: String?
    var contacts: ContactsModel
    var birthday: BirthdayModel?
    var profileImageIdentifier: String?
    var linkedAssetIdentifiers: [String] = []
    var faceEmbedding: [Float]? = nil
    var isFavorite: Bool = false
}
