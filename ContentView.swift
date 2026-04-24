//
//  ContentView.swift
//  Memorize
//
//  Created by Hans Hartowidjojo on 23/04/26.
//

import SwiftUI
struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
                // Swap content based on selected tab
                switch selectedTab {
                case 0:
                    NavigationStack {
                        HomeView(selectedTab: $selectedTab)
                    }
                case 1:
                    CollectionView(selectedTab: $selectedTab )
                default:
                    NavigationStack {
                        HomeView(selectedTab: $selectedTab)
                    }
                }
                

    }
}
#Preview {
    ContentView()
}
