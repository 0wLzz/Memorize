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

    func filteredPeople(for interest: InterestModel) -> [PersonModel] {
        let byInterest = PersonModel.people.filter {
            $0.interest?.name == interest.name
        }

        if searchQuery.isEmpty {
            return byInterest
        }
        return byInterest.filter {
            $0.name.localizedCaseInsensitiveContains(searchQuery)
        }
    }

}
