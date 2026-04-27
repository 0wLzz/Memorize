//
//  InterestField.swift
//  Memorize
//
//  Created by Owen Limantoro on 24/04/26.
//

import SwiftUI

struct InterestField: View {
    @State var text: String = ""

    @State private var showList: Bool = false
    
    var body: some View {
        HStack {
            Text("Interest")
    
            Divider()
                .frame(height: 24)
            
            Text(text == "" ? "Select or add new" : text)
                .foregroundStyle(.blue)
                .onTapGesture {
                    showList = true
                }

            Spacer()
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .sheet(isPresented: $showList) {
            InterestSheet(text: $text)
        }
    }
}

#Preview {
    InterestField()
}
