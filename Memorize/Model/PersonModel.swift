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
    var Interest: InterestModel?
    var notes: String?
    var picturea: [String]?
    
//    #if DEBUG
    static let people: [PersonModel] = [
        PersonModel(name: "Hans", imageName: "Hans", Interest: InterestModel(name: "Board Games", icon: "puzzlepiece")),
        PersonModel(name: "Owen", imageName: "Owen", Interest: InterestModel(name: "Music", icon: "music.note")),
        PersonModel(name: "Asa", imageName: "Asa", Interest: InterestModel(name: "Art", icon: "paintbrush"))
    ]
//    #endif
}
