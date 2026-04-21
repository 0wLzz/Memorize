//
//  PersonDetailView.swift
//  Memorize
//
//  Created by Owen Limantoro on 20/04/26.
//

import SwiftUI

struct PersonDetailView: View {
    var person: PersonModel

    func dummyFunction() {

    }

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack(alignment: .center, spacing: 4) {
                    ZStack(alignment: .bottom) {
                        Image(person.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(
                                width: geo.size.width,
                                height: geo.size.height * 0.7,
                                alignment: .center
                            )
                            .clipped()

                        LinearGradient(
                            colors: [
                                Color.clear,
                                Color.white.opacity(0.3),
                                Color.white.opacity(0.75),
                                Color.white,
                            ],
                            startPoint: .center,
                            endPoint: .bottom
                        )
                        .frame(
                            width: geo.size.width,
                            height: geo.size.height * 0.7,
                            alignment: .center
                        )

                        VStack(spacing: 4) {
                            Text(person.name)
                                .font(.largeTitle)

                            Text(person.Interest?.name ?? "No Interest")
                                .font(.headline)
                                .padding(.bottom, 10)

                            // Contacts
                            HStack(spacing: 30) {
                                Image("Whatsapp")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipped()
                                    .clipShape(Circle())

                                Image("Discord")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipped()
                                    .background(.white)
                                    .clipShape(Circle())

                                Image("Mail")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipped()
                                    .clipShape(Circle())

                                Image("Instagram")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipped()
                                    .clipShape(Circle())
                            }

                        }
                        .foregroundStyle(.black)
                        .padding()

                    }
                    .ignoresSafeArea(edges: .top)

                    // Bio
                    Text(person.notes ?? "")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 14)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color.white)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding(.horizontal, 16)

                    // Grid preview (3 columns)
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible(), spacing: 2),
                            GridItem(.flexible(), spacing: 2),
                            GridItem(.flexible(), spacing: 2),
                        ],
                        spacing: 2
                    ) {
                        ForEach(0..<100, id: \.self) { _ in
                            Image("Hans")
                                .resizable()
                                .scaledToFill()
                                .frame(height: 100)
                                .clipped()
                                .clipShape(RoundedRectangle(cornerRadius: 2))
                        }
                    }
                    .padding(16)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .padding(.bottom, 32)
                }
            }
            .ignoresSafeArea()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dummyFunction()
                    } label: {
                        Image(systemName: "star")
                    }
                }

                ToolbarSpacer(placement: .topBarTrailing)

                ToolbarItem(placement: .primaryAction) {
                    NavigationLink {
                        EditPersonView()
                    }
                    label: {
                        Image(systemName: "pencil")
                    }
                }
            }
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
