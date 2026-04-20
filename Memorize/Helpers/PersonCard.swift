//
//  PersonCard.swift
//  Memorize
//
//  Created by Owen Limantoro on 19/04/26.
//

import SwiftUI

struct PersonCard: View {
    var person: PersonModel
    
    var body: some View {
        Rectangle()
            .frame(width: 160, height: 180)
            .foregroundStyle(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .overlay {
                ZStack(alignment: .bottom) {
                    Image(person.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 170)
                        .clipped()
                    
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .frame(height: 100)
                        .mask(
                            alignment: Alignment.bottomLeading, {
                                LinearGradient(
                                    colors: [.clear, .white],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            }
                        )
                    
                    VStack(alignment: .center) {
                        Text(person.name)
                            .font(.title)
                            .foregroundColor(.white)
                        
                        HStack {
                            Image(systemName: person.Interest?.icon ?? "")
                            
                            Text(person.Interest?.name ?? "No Interest")
                        }
                        .font(.caption)
                        .foregroundColor(.white)
                    }
                    .padding()
                    
                }
                .frame(width: 150, height: 170)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
    }
}

#Preview {
    let boardgames = InterestModel(name: "Board Games", icon: "puzzlepiece")
    let Hans = PersonModel(name: "Hans", imageName: "Hans", Interest: boardgames)
    PersonCard(person: Hans)
}
