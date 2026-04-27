//
//  CollectionView.swift
//  Memorize
//
//  Created by Hans Hartowidjojo on 23/04/26.
//

import SwiftUI

struct CollectionView: View {
    @EnvironmentObject var repo: PersonRepository

    @Binding var selectedTab: Int

    private let columns = [
        GridItem(.fixed(160), spacing: 16),
        GridItem(.fixed(160), spacing: 16),
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach($repo.persons) { $person in
                            NavigationLink {
                                PersonDetailView(person: $person)
                            } label: {
                                PersonCard(person: $person.wrappedValue)
                            }
                        }
                    }
                    .padding(.top, 70)
                    
                    .padding()

                }
                VStack {
                    Text("Collection")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .padding(.top, 10)
                        .background(.background)

                    Spacer()
                }
                CameraBar(
                    selectedTab: $selectedTab,
                ).offset(y: 15)

            }
        }
    }
}

#Preview {
    CollectionView(
        selectedTab: .constant(1),
    )
}
