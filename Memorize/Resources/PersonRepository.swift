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
    
    init() {
        // For now initialize a hardcoded list
        #if DEBUG
        self.persons = PersonModel.people
        #endif
    }
}
