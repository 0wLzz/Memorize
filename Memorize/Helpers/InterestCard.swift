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
                HStack {
                    Image(systemName: interest.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                        .padding(3)
                    Text(interest.name)
                        .scaledToFit()
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, minHeight: 60)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.accent)
                )
            .frame(height: 80)
        }
}

#Preview {
    InterestCard(interest: InterestModel.interests[0])
}
