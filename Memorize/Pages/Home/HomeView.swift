//
//  HomeView.swift
//  Memorize
//
//  Created by Hans Hartowidjojo on 20/04/26.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        ZStack{
            // if there's nothing in the database, use EmptyHome, if not, provide it with the REAL home page
            EmptyHome()
            CameraBar()
        }
        
    }
}

#Preview {
    HomeView()
}
