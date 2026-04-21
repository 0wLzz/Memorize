//
//  EmptyState.swift
//  Memorize
//
//  Created by Hans Hartowidjojo on 20/04/26.
//  Use this only for empty state at Home (if there's nobody)

import SwiftUI

struct EmptyHome: View {
    var body: some View {
        VStack {
            Image(systemName: "person.fill.questionmark")
                .resizable()
                .frame(width: 200, height: 150)
                .foregroundStyle(Color.secondary)
            Text("Have you met anyone?")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
        }
        
    }
}

#Preview {
    EmptyHome()
}
