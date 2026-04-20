//
//  PersonDetailView.swift
//  Memorize
//
//  Created by Owen Limantoro on 20/04/26.
//

import SwiftUI

struct PersonDetailView: View {
    let columns = [GridItem(.flexible(), spacing: 1), GridItem(.flexible(), spacing: 1), GridItem(.flexible(), spacing: 1)]
    var person: PersonModel

    var body: some View {
        ScrollView {
            VStack {
                /// Header Section
                ZStack(alignment: .bottom) {
                    Image(person.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: .infinity, height: 450)
                        .clipped()

                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .frame(height: 100)
                        .mask(
                            alignment: Alignment.bottomLeading,
                            {
                                LinearGradient(
                                    colors: [.clear, .white],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            }
                        )

                    VStack(alignment: .center) {
                        Text(person.name)
                            .font(.largeTitle)
                            .foregroundColor(.white)

                        HStack {
                            Image(systemName: person.Interest?.icon ?? "")

                            Text(person.Interest?.name ?? "No Interest")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                    }
                    .padding()
                }

                /// Notes Section
                Rectangle()
                    .fill(.blue)
                    .frame(width: .infinity, height: 100)

                /// Pictures Section
                LazyVGrid(columns: columns, spacing: 1) {
                    ForEach(1...9, id: \.self) { _ in
                        Image("Hans")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 140)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 2))

                    }

                }
            }
            .padding(.horizontal, 400)
        }
    }
}

#Preview {
    let hans = PersonModel(
        name: "Hans",
        imageName: "Hans",
        Interest: InterestModel(name: "Board Games", icon: "puzzlepiece")
    )
    PersonDetailView(person: hans)
}
