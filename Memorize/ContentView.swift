//
//  ContentView.swift
//  Memorize
//
//  Created by Owen Limantoro on 22/04/26.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var repo: PersonRepository
    
    var body: some View {
        HomeView(people: $repo.persons)
        
//        InteresetView(repo: repo, interest: InterestModel.interests.first!)
    }
}

#Preview {
    ContentView()
}
