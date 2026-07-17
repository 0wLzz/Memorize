//
//  PhotoRepository.swift
//  Memorize
//
//  Created by Owen Limantoro on 22/04/26.
//

import Foundation
import Combine

final class PersonRepository: ObservableObject {
    @Published var persons: [PersonModel]
    @Published var interests: [InterestModel] = InterestModel.interests
    
    init() {
        #if DEBUG
        self.persons = []
        #endif
    }
}
