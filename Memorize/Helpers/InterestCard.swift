//
//  SwiftUIView.swift
//  Memorize
//
//  Created by Owen Limantoro on 19/04/26.
//

import SwiftUI

struct InterestCard: View {
    
    var interest: InterestModel
    //    var body: some View {
    //            HStack {
    //                Image(systemName: interest.icon)
    //                    .resizable()
    //                    .frame(width: 50, height: 40)
    //                    .foregroundColor(Color.white)
    //                    .padding(3)
    //                Text(interest.name)
    //                    .scaledToFit()
    //                    .controlSize(.large)
    //                    .foregroundColor(Color.white)
    //            }
    //                            .background(
    //                                Rectangle()
    //                                    .fill(Color.secondary)
    //                                    .frame(width: 200, height: 100)
    //                                    .cornerRadius(10)
    //                            )
    //
    //                }
    var body: some View {
            GeometryReader { geo in
                HStack {
                    Image(systemName: interest.icon)
                        .resizable()
                        .frame(width: geo.size.width * 0.2, height: geo.size.width * 0.2)
                        .foregroundColor(.white)
                        .padding(3)
                    Text(interest.name)
                        .scaledToFit()
                        .foregroundColor(.white)
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.secondary)
                )
            }
            .frame(height: 80) // GeometryReader needs an explicit height
        }
}

#Preview {
    InterestCard(interest: InterestModel.interests[0])
}
