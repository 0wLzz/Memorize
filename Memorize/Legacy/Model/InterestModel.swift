//
//  InterestModel.swift
//  Memorize
//
//  Created by Owen Limantoro on 19/04/26.
//

import Foundation

struct InterestModel: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var icon: String // Using SF Symbols
    
    //    #if DEBUG
    static let interests: [InterestModel] = [
        InterestModel(name: "Board Games", icon: "puzzlepiece"),
        InterestModel(name: "Music", icon: "music.note"),
        InterestModel(name: "Art", icon: "paintbrush")
    ]
    //    #endif
}

