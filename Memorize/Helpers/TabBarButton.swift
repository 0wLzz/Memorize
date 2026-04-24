//
//  TabBarButton.swift
//  Memorize
//
//  Created by Hans Hartowidjojo on 23/04/26.
//

import SwiftUI
struct TabBarButton: View {
    let systemImageName: String
    let fillSystemImageName: String
    let title: String
    let action: () -> Void
    var isSelected: Bool = false
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: isSelected ? fillSystemImageName : systemImageName)
                    .font(.title)
                Text(title)
                    .font(.caption)
                    .fontWeight(.semibold)

            }
            .foregroundColor(isSelected ? .primary : .secondary)
            .padding(.horizontal)
        }
    }
}
