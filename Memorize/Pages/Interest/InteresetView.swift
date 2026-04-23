//
//  InteresetView.swift
//  Memorize
//
//  Created by Owen Limantoro on 19/04/26.
//

import SwiftUI


struct InteresetView: View {
    @StateObject private var interestViewModel = InterestViewModel()
    let interest: InterestModel

    let columns = [
        GridItem(.fixed(160), spacing: 16),
        GridItem(.fixed(160), spacing: 16),
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(interestViewModel.filteredPeople(for: interest)) { person in
                        NavigationLink {
                            PersonDetailView(person: person)
                        } label: {
                            PersonCard(person: person)
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

#Preview {
    InteresetView(interest: InterestModel.interests[0])
}
