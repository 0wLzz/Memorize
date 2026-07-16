//
//  CameraButton.swift
//  Memorize
//
//  Created by Hans Hartowidjojo on 20/04/26.
//  Base Camera Button

import PhotosUI
import SwiftUI

struct CameraButton: View {
    @State private var selectedItem: PhotosPickerItem?  // holds the selected photo item
    @State private var selectedImage: UIImage?  // holds the loaded image
    @State private var ShowingCamera = false  // control camera sheet visibility

    struct DarkenButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .brightness(configuration.isPressed ? -0.15 : 0)
                .animation(
                    .easeInOut(duration: 0.1),
                    value: configuration.isPressed
                )
        }
    }

    @State private var goToEdit = false  // Should go to edit or no

    var body: some View {
        Button(action: { ShowingCamera = true }) {
            Image(systemName: "camera")
                .scaledToFit()
                .font(.system(size: 40))
                .foregroundColor(Color.white)
                .background(
                    Circle().fill(Color.accent).frame(
                        width: 90,
                        height: 90
                    )
                )
        }
        .buttonStyle(DarkenButtonStyle())
        .fullScreenCover(isPresented: $ShowingCamera) {
            CameraView(
                image: $selectedImage,
                onImageCaptured: {
                    goToEdit = true
                }
            )
            .ignoresSafeArea()
            .frame(width: 402, height: 874)
        }
        .navigationDestination(isPresented: $goToEdit) {
            if let image = selectedImage {
                AddPersonView(image: image)
            }
        }
    }
}

#Preview {
    CameraButton()
}
