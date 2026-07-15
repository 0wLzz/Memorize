//
//  PersonModel.swift
//  Memorize
//
//  Created by Owen Limantoro on 19/04/26.
//

import Foundation

struct PersonModel: Identifiable, Codable {
    var id: UUID
    var name: String
    var notes: String?
    var contacts: ContactsModel
    var birthday: BirthdayModel?
    var profileImageIdentifier: String?      // path or PHAsset.localIdentifier — resolved by a Service
    var linkedAssetIdentifiers: [String] = [] // filled in once PhotosKit exists (step 3)
    var faceEmbedding: [Float]? = nil         // filled in once CoreML exists (step 4)
    var isFavorite: Bool = false
}
