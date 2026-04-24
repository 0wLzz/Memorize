//
//  HomeView.swift
//  Memorize
//
//  Created by Hans Hartowidjojo on 20/04/26.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var repo: PersonRepository
    @Binding var people: [PersonModel]
    @Binding var metToday: [PersonModel]
    @State var interests: [InterestModel]
    var favorites: [PersonModel] { [] }

    init(people: Binding<[PersonModel]>) {
        self._people = people
        self._metToday = people
        self.interests = InterestModel.interests
    }

    // grid setting for lazyHgrid and lazyVgrid
    private let hColumns = [GridItem(.adaptive(minimum: 90))]
    private let vColumns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
    ]

    private struct SectionHeader: View {
        let title: String
        var body: some View {
            Text(title)
                .font(.title2.bold())
                .padding(.horizontal)
        }
    }

    var body: some View {
        if people.isEmpty {
            ZStack {
                EmptyHome()
                CameraBar()
            }
        } else {
            NavigationStack {
                ZStack {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 5) {
                            /// People You've Met Section
                            SectionHeader(title: "People You've Met")
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 20) {
                                    ForEach($metToday, id: \.id) { $person in
                                        NavigationLink {
                                            PersonDetailView(person: $person)
                                        } label: {
                                            PersonCard(
                                                person: $person.wrappedValue
                                            )
                                        }

                                    }
                                    .padding()
                                }

                            }

                            /// Favorites Section
                            SectionHeader(title: "Favorites")
                            if favorites.isEmpty {
                                Text("You don't have a best friend :(")
                                    .foregroundStyle(Color.secondary)
                                    .padding()
                            } else {

                            }

                            /// Interests Section
                            SectionHeader(title: "Interests")
                                .padding(.vertical)

                            LazyVGrid(columns: vColumns) {
                                ForEach(interests, id: \.id) { interest in
                                    NavigationLink {
                                        InteresetView(
                                            repo: repo,
                                            interest: interest
                                        )
                                    } label: {
                                        InterestCard(interest: interest)
                                    }
                                }.padding()
                            }
                        }
                    }
                    CameraBar()
                }
                .navigationDestination(for: InterestModel.self) { interest in
                    InteresetView(repo: repo, interest: interest)
                }
            }
        }

    }
}
