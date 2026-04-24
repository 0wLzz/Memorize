//
//  HomeView.swift
//  Memorize
//
//  Created by Hans Hartowidjojo on 20/04/26.
//

import SwiftUI

struct HomeView: View {
    // setting up the ingredients for the home page
    @State private var people: [PersonModel] = PersonModel.people
    @State private var interests: [InterestModel] = InterestModel.interests
    var metToday: [PersonModel] { people }
    var favorites: [PersonModel] { [] }

    // grid setting for lazyHgrid and lazyVgrid
    private let hColumns = [GridItem(.adaptive(minimum: 90))]
    private let vColumns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
    ]

    // add status for CameraBar
    @Binding var selectedTab: Int

    private struct SectionHeader: View {
        let title: String
        var body: some View {
            Text(title)
                .font(.title2.bold())
                .padding(.horizontal)
        }
    }

    var body: some View {

        // if there's nothing in the database, use EmptyHome, if not, provide it with the REAL home page
        if people.isEmpty {
            ZStack {
                EmptyHome()
                CameraBar(
                    selectedTab: $selectedTab,
                ).offset(y:15)
            }
        } else {
            NavigationStack {
                ZStack {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 5) {
                            //// People You've Met Section
                            SectionHeader(title: "People You've Met")
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: -3) {
                                    ForEach(metToday, id: \.id) { person in
                                        NavigationLink {
                                            PersonDetailView(person: person)
                                        } label: {
                                            PersonCard(person: person)
                                        }

                                    }
                                    .padding()
                                }
                            }
                            Divider().padding(.horizontal)
                            //// Favorites Section
                            SectionHeader(title: "Favorites")
                            if favorites.isEmpty {
                                Text(":(")
                                    .foregroundStyle(Color.secondary)
                                    .padding()
                            } else {

                            }
                            Divider().padding(.horizontal)
                            SectionHeader(title: "Interests")
                                .padding(.vertical)
                            LazyVGrid(columns: vColumns) {
                                ForEach(interests, id: \.id) { interest in
                                    NavigationLink {
                                        InteresetView(interest: interest)
                                    } label: {
                                        InterestCard(interest: interest)
                                    }
                                }.padding(.horizontal)
                            }
                        }
                        .padding(.top, 70)
                        .padding(.leading,10)
                    }
                    VStack{
                        Text("Home")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                            .padding(.top,10)
                            .background(.background)
                            
                        Spacer()
                    }
                    CameraBar(
                        selectedTab: $selectedTab,
                    ).offset(y:15)

                }.navigationDestination(for: InterestModel.self) { interest in
                    InteresetView(interest: interest)

                }
            }
        }

    }
}

#Preview {
    HomeView(
        selectedTab: .constant(0),
    )
}
