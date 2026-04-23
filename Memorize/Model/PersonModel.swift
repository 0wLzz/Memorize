//
//  PersonModel.swift
//  Memorize
//
//  Created by Owen Limantoro on 19/04/26.
//

import Foundation

struct PersonModel : Identifiable {
    let id = UUID()
    var name: String
    var imageName: String
    var interest: InterestModel?
    var notes: String?
    var pictures: [String]?
    var contacts: ContactsModel?
    
    #if DEBUG
    static let people: [PersonModel] = [
        PersonModel(name: "Hans", imageName: "Hans", interest: InterestModel.interests[0]),
        PersonModel(name: "John", imageName: "Hans", interest: InterestModel.interests[1]),
        PersonModel(name: "Lisa", imageName: "Hans", interest: InterestModel.interests[2])
    ]
    #endif
}
