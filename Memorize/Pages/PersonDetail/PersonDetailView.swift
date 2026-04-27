//
//  PersonDetailView.swift
//  Memorize
//
//  Created by Owen Limantoro on 20/04/26.
//

import SwiftUI

struct PersonDetailView: View {
    @Binding var person: PersonModel
    
    func changeStatus() {
        person.isFavorite = !person.isFavorite
    }

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack(alignment: .center, spacing: 4) {
                    ZStack(alignment: .bottom) {
                        if let profileImage = person.profileImage {
                            Image(uiImage: profileImage)
                                .resizable()
                                .scaledToFill()
                                .frame(
                                    width: geo.size.width,
                                    height: geo.size.height * 0.7,
                                    alignment: .center
                                )
                                .clipped()
                                .overlay(
                                    Rectangle()
                                        .fill(.ultraThinMaterial)
                                        .mask(
                                            LinearGradient(colors: [
                                                Color(.clear),
                                                Color(.black)
                                            ], startPoint: .center, endPoint: .bottom)
                                        )
                                )
                            .frame(
                                width: geo.size.width,
                                height: geo.size.height * 0.7,
                                alignment: .center
                            )
                        }

                        VStack(spacing: 10) {
                            Text(person.name)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)

                            // Contacts
                            HStack(spacing: 40) {
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
                            GridItem(.flexible(), spacing: 1),
                            GridItem(.flexible(), spacing: 1),
                            GridItem(.flexible(), spacing: 1),
                        ],
                        spacing: 1
                    ) {
                        ForEach(0..<100, id: \.self) { _ in
                            Image("Hans")
                                .resizable()
                                .scaledToFill()
                                .frame(height:100)
                                .clipped()
                                .clipShape(RoundedRectangle(cornerRadius: 4))
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
                        changeStatus()
                    } label: {
                        if person.isFavorite {
                            Image(systemName: "star.fill")
                        }
                        else {
                            Image(systemName: "star")
                        }
                    }
                }

                ToolbarSpacer(placement: .topBarTrailing)

                ToolbarItem(placement: .primaryAction) {
                    NavigationLink {
                        EditPersonView(person: $person)
                    }
                    label: {
                        Image(systemName: "pencil")
                    }
                }
            }
        }
    }
}

//#Preview {
//    let hans = PersonModel(
//        name: "Hans",
//        imageName: "Hans",
//        interest: InterestModel(name: "Board Games", icon: "puzzlepiece")
//    )
//    PersonDetailView(person: hans)
//}
