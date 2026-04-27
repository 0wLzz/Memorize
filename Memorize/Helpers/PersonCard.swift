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
        ZStack(alignment: .bottomLeading) {
            if let profileImage = person.profileImage {
                Image(uiImage: profileImage)
                    .resizable()
                    .scaledToFit()
            }

            Rectangle()
                .frame(height: 70)
                .opacity(0.9)
                .mask(
                    alignment: Alignment.bottomLeading,
                    {
                        LinearGradient(
                            colors: [.clear, .black],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    }
                )

            VStack(alignment: .leading) {
                Text(person.name)
                    .font(.system(size: 20))
                    .foregroundColor(.white)

            }
            .padding()
        }
        .frame(width: 150, height: 170)
        .clipShape(RoundedRectangle(cornerRadius: 10))

    }
}

//#Preview {
//    let boardgames = InterestModel.interests[0]
//    let Hans = PersonModel.people[0]
//    PersonCard(person: Hans)
//}
