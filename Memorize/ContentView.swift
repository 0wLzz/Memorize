//
//  ContentView.swift
//  Memorize
//
//  Created by Owen Limantoro on 22/04/26.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var repo: PersonRepository
    @State private var selectedTab = 0

    var body: some View {
        switch selectedTab {
        case 0:
            NavigationStack {
                HomeView(people: $repo.persons, selectedTab: $selectedTab)
            }
        case 1:
            CollectionView(repo: _repo, selectedTab: $selectedTab)

        default:
            NavigationStack {

                HomeView(people: $repo.persons, selectedTab: $selectedTab)
            }
        }
    }
}

#Preview {
    ContentView()
}
