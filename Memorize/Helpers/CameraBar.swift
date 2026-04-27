//
//  CameraBar.swift
//  Memorize
//
//  Created by Hans Hartowidjojo on 20/04/26.
//  Camera for Home Page

import SwiftUI

struct CameraBar: View {
    @Binding var selectedTab: Int

    var body: some View {
        ZStack {
            UnevenRoundedRectangle(
                topLeadingRadius: 0,
                bottomLeadingRadius: 42,
                bottomTrailingRadius: 42,
                style: .continuous
            )

            .fill(.ultraThickMaterial)
            .frame(width: 402, height: 95)
            .position(x: 200, y: 399)
            HStack(spacing: 0) {
                TabBarButton(
                    systemImageName: "house",
                    fillSystemImageName: "house.fill",
                    title: "Home",
                    action: { selectedTab = 0 },
                    isSelected: selectedTab == 0
                )
                .offset(x: -30)
                CameraButton()
                    .frame(width: 90, height: 90)
                    .padding([.leading, .trailing, .bottom])
                    .padding(.bottom)
                    .offset(x: 5, y: -15)

                TabBarButton(
                    systemImageName: "person.crop.square.on.square.angled",
                    fillSystemImageName:
                        "person.crop.square.on.square.angled.fill",
                    title: "Collection",
                    action: { selectedTab = 1 },
                    isSelected: selectedTab == 1
                )
                .offset(x: 30)
            }
            .padding(.trailing, 25)
            .padding(.leading, 29)

        }
        .position(x: 200, y: 748)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CameraBar(selectedTab: .constant(0))
}
