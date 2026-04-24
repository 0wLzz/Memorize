//
//  InteresetView.swift
//  Memorize
//
//  Created by Owen Limantoro on 19/04/26.
//

import SwiftUI

struct InteresetView: View {
    @StateObject private var interestViewModel: InterestViewModel
    let interest: InterestModel
    
    init(repo: PersonRepository, interest: InterestModel) {
        _interestViewModel = StateObject(wrappedValue: InterestViewModel(repo: repo))
        self.interest = interest
    }
    
    var filteredPeopleIndex: [Int] {
        interestViewModel.persons.indices.filter {
            interestViewModel.persons[$0].interest == interest
        }
    }

    let columns = [
        GridItem(.fixed(160), spacing: 16),
        GridItem(.fixed(160), spacing: 16),
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 8) {
                    // Filter the index not the people itself
                    ForEach(filteredPeopleIndex, id: \.self) { index in
                        NavigationLink {
                            PersonDetailView(person: $interestViewModel.persons[index])
                        } label: {
                            PersonCard(person: interestViewModel.persons[index])
                        }
                    }
                }
            }
//            .searchable(text: $interestViewModel.searchQuery)
            .navigationTitle(interest.name)  // shows the interest name
            .padding(15)
        }
    }
}
