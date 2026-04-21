//
//  CameraBar.swift
//  Memorize
//
//  Created by Hans Hartowidjojo on 20/04/26.
//  Camera for Home Page

import SwiftUI

struct CameraBar: View {
    var body: some View {
        Rectangle()
            .frame(width:402, height: 100)
            .foregroundColor(.gray)
            .overlay{
                CameraButton().position(x: 200, y:12)
            }.position(x:200,y:770)
                }
            }


#Preview {
    CameraBar()
}
