//
//  ProfileView.swift
//  Memorize
//
//  Created by Owen Limantoro on 20/04/26.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .center, spacing: 0) {
                Image("Hans")
                    .resizable()
                    .scaledToFill()
                    .frame(height: geo.size.height * 0.7)
                    .clipped()
                    .ignoresSafeArea(edges: .top)
            }
        }
    }
}

#Preview {
    ProfileView()
}
