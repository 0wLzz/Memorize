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

    @State private var goToEdit = false  // Should go to edit or no

    var body: some View {
        NavigationStack {
            Button(action: { ShowingCamera = true }) {
                Image(systemName: "camera")
                    .scaledToFit()
                    .font(.system(size: 50))
                    .foregroundColor(Color.white)
                    .background(
                        Circle().fill(Color.black).frame(width: 100, height: 100)
                    )
            }
            .fullScreenCover(isPresented: $ShowingCamera) {
                CameraView(
                    image: $selectedImage,
                    onImageCaptured: {
                        goToEdit = true
                    }
                )
                .ignoresSafeArea()
            }
            .navigationDestination(isPresented: $goToEdit) {
                if let image = selectedImage {
                    AddPersonView(image: image)
                }
            }
        }
    }
}

#Preview {
    CameraButton()
}
