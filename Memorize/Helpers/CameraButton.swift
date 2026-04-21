//
//  CameraButton.swift
//  Memorize
//
//  Created by Hans Hartowidjojo on 20/04/26.
//  Base Camera Button

import SwiftUI
import PhotosUI

struct CameraButton: View {
    @State private var selectedItem: PhotosPickerItem? // holds the selected photo item
    @State private var selectedImage: UIImage? // holds the loaded image
    @State private var ShowingCamera = false // control camera sheet visibility
    var body: some View {
        
        // This button is used to take pictures
        Button(action: {ShowingCamera = true}) {
                        Image(systemName: "camera")
                            .scaledToFit()
                            .font(.system(size: 50))
                            .foregroundColor(Color.white)
                            .background(
                                Circle().fill(Color.black).frame(width: 100, height: 100)
                            )
                    }
        .fullScreenCover(isPresented: $ShowingCamera) {
            CameraView(image: $selectedImage)
                .ignoresSafeArea()
                .frame(width: 402, height: 874)
        }
                }
            }

#Preview {
    CameraButton()
}
