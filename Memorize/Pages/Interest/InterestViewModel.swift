//
//  InterestViewModel.swift
//  Memorize
//
//  Created by Owen Limantoro on 20/04/26.
//

import Combine
import Foundation

final class InterestViewModel: ObservableObject {
    @Published var persons: [PersonModel] = []
    @Published var searchQuery: String = ""

    init(repo: PersonRepository) {
        repo.$persons
            .assign(to: &$persons)
    }
    
    var filteredPeople: [PersonModel] {
        if searchQuery.isEmpty {
            return persons
        }
        
        return PersonModel.people.filter { person in
            person.name.localizedCaseInsensitiveContains(searchQuery)
            
        }
    }
}
