//
//  InterestViewModel.swift
//  Memorize
//
//  Created by Owen Limantoro on 20/04/26.
//

import Combine
import Foundation

final class InterestViewModel: ObservableObject {
    @Published var searchQuery: String = ""
    
    var filteredPeople: [PersonModel] {
        if searchQuery.isEmpty {
            return PersonModel.people
        }
        
        return PersonModel.people.filter { person in
            person.name.localizedCaseInsensitiveContains(searchQuery)
            
        }
    }
}
