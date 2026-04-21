//
//  InteresetView.swift
//  Memorize
//
//  Created by Owen Limantoro on 19/04/26.
//

import SwiftUI

struct InteresetView: View {
    @StateObject private var interestViewModel = InterestViewModel()

    let columns = [
        GridItem(.fixed(160), spacing: 16),
        GridItem(.fixed(160), spacing: 16),
    ]
    
    let hans = PersonModel(
        name: "Hans",
        imageName: "Hans",
        Interest: InterestModel(name: "Board Games", icon: "puzzlepiece")
    )

    
    var body: some View {
        NavigationStack{
            ScrollView {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(interestViewModel.filteredPeople) { person in

                        NavigationLink {
                            PersonDetailView(person: person)
                        } label: {
                            PersonCard(person: person)
                        }
                    }
                }
            }
            .searchable(text: $interestViewModel.searchQuery)
            .navigationTitle("Interests")
            .padding(15)
        }
    }
}

#Preview {
    InteresetView()
}
