//
//  SwiftUIView.swift
//  Memorize
//
//  Created by Owen Limantoro on 19/04/26.
//

import SwiftUI

struct InterestCard: View {
    
    var interest: InterestModel
    var body: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: interest.icon)
                    .resizable()
                    .frame(width: 50, height: 40)
                    .foregroundColor(Color.white)
                    .padding(3)
                Text(interest.name)
                    .scaledToFit()
                    .controlSize(.large)
                    .foregroundColor(Color.white)
            }
                            .background(
                                Rectangle()
                                    .fill(Color.secondary)
                                    .frame(width: 200, height: 100)
                                    .cornerRadius(10)
                            )
                    }
                }
            }

#Preview {
    InterestCard(interest: InterestModel.interests[0])
}
