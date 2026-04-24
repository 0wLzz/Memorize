//
//  ContentView.swift
//  Memorize
//
//  Created by Hans Hartowidjojo on 23/04/26.
//

import SwiftUI
struct ContentView: View {
    @State private var selectedTab = 0
    @State private var isEarningsEntryViewShown = false

    var body: some View {
                // Swap content based on selected tab
                switch selectedTab {
                case 0:
                    NavigationStack {
                        HomeView(selectedTab: $selectedTab, isEarningsEntryViewShown: $isEarningsEntryViewShown)
                    }
                case 1:
                    CollectionView(selectedTab: $selectedTab, isEarningsEntryViewShown: $isEarningsEntryViewShown)
                default:
                    NavigationStack {
                        HomeView(selectedTab: $selectedTab, isEarningsEntryViewShown: $isEarningsEntryViewShown)
                    }
                }
                

    }
}
#Preview {
    ContentView()
}
