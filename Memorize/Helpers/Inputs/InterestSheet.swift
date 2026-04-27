//
//  InterestSheet.swift
//  Memorize
//
//  Created by Owen Limantoro on 24/04/26.
//

import SwiftUI

struct InterestSheet: View {
    @Binding var text : String
    @Environment(\.dismiss) var dismiss
    @State var options: [String] = ["Apple", "Banana", "Mango Juice"]
    
    var filteredOptions: [String] {
        if text.isEmpty {
            return options
        }

        return options.filter {
            $0.lowercased().hasPrefix(text.lowercased())
        }
    }

    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(filteredOptions, id: \.self) { option in
                    Button {
                        text = option
                    } label: {
                        HStack {
                            // Highlight matching prefix
                            Text(option)
                                .font(.system(size: 16))
                                .foregroundStyle(.black)
                            
                            Spacer()
                            
                            if text.lowercased() == option.lowercased() {
                                Image(systemName: "checkmark")
                                    .font(.system(size: 12))

                            }
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 11)
                        .contentShape(Rectangle())
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "cross")
                        .frame(width: 32, height: 32)
                        .background(.ultraThinMaterial)
                        .foregroundStyle(.primary)
                        .clipShape(Circle())
                }
            }

            ToolbarItem(placement: .principal) {
                Text("Interest")
            }
        }
    }
}

#Preview {
    InterestSheet(text: .constant("Test"))
}
