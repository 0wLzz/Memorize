//
//  CollectionView.swift
//  Memorize
//
//  Created by Hans Hartowidjojo on 23/04/26.
//

import SwiftUI

struct CollectionView: View {
    @Binding var selectedTab: Int
    @Binding var isEarningsEntryViewShown: Bool

    let people: [PersonModel] = PersonModel.people

    private let columns = [
        GridItem(.fixed(160), spacing: 16),
        GridItem(.fixed(160), spacing: 16),
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(people) { person in
                            NavigationLink {
                                PersonDetailView(person: person)
                            } label: {
                                PersonCard(person: person)
                            }
                        }
                    }
                    .padding(.top, 70)
                    
                }
                VStack{
                    Text("Collections")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .padding(.top,10)
                        .background(.background)
                        
                    Spacer()
                }
                CameraBar(
                    selectedTab: $selectedTab,
                    isEarningsEntryViewShown: $isEarningsEntryViewShown
                ).offset(y:15)

            }
        }
    }
}

#Preview {
    CollectionView(
        selectedTab: .constant(1),
        isEarningsEntryViewShown: .constant(false)
    )
}
