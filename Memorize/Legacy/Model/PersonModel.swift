//
//  PersonModel.swift
//  Memorize
//
//  Created by Owen Limantoro on 19/04/26.
//

import Foundation
import PhotosUI

struct PersonModel: Identifiable {
    let id = UUID()
    var name: String
    var notes: String?
    var pictures: [String]?
    var interest: InterestModel
    var contacts: ContactsModel
    var profileImage : UIImage? = nil
    var isFavorite: Bool = false


//    #if DEBUG
//        static let people: [PersonModel] = [
//            PersonModel(
//                name: "Hans",
//                imageName: "Hans",
//                interest: InterestModel.interests[0],
//                contacts: ContactsModel.contactsExample
//            ),
//            PersonModel(
//                name: "John",
//                imageName: "Hans",
//                interest: InterestModel.interests[1],
//                contacts: ContactsModel.contactsExample
//            ),
//            PersonModel(
//                name: "Lisa",
//                imageName: "Hans",
//                interest: InterestModel.interests[2],
//                contacts: ContactsModel.contactsExample
//            ),
//        ]
//    #endif
}
