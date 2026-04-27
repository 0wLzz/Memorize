//
//  PersonModel.swift
//  Memorize
//
//  Created by Owen Limantoro on 19/04/26.
//

import Foundation
import PhotosUI
import SwiftData

@Model
final class PersonModel: Identifiable {
    var id = UUID()
    var name: String
    var notes: String?
    var pictures: [String]?
    var interest: InterestModel
    var contacts: ContactsModel
    var profileImageData: Data? = nil  // store as Data
    var isFavorite: Bool = false

    // Computed property for convenience
    var profileImage: UIImage? {
        get {
            guard let data = profileImageData else { return nil }
            return UIImage(data: data)
        }
        set {
            profileImageData = newValue?.jpegData(compressionQuality: 0.8)
        }
    }

    init(id: UUID = UUID(), name: String, notes: String? = nil, pictures: [String]? = nil, interest: InterestModel, contacts: ContactsModel, profileImage: UIImage? = nil, isFavorite: Bool = false) {
        self.id = id
        self.name = name
        self.notes = notes
        self.pictures = pictures
        self.interest = interest
        self.contacts = contacts
        self.profileImageData = profileImage?.jpegData(compressionQuality: 0.8)
        self.isFavorite = isFavorite
    }
}
