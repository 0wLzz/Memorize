//
//  InterestSheet.swift
//  Memorize
//

//  Created by Owen Limantoro on 24/04/26.
//

import SwiftUI

struct InterestSheet: View {
    @Environment(\.dismiss) var dismiss

    @State private var showAddField: Bool = false
    @State private var newInterestName: String = ""
    @Binding var interest: String
    @Binding var options: [InterestModel]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 0) {
                    if showAddField {
                        HStack {
                            TextField(
                                "New interest name",
                                text: $newInterestName
                            )
                            .font(.system(size: 16))
                            .padding(.horizontal, 14)
                            .padding(.vertical, 11)

                            Button("Add") {
                                let trimmed =
                                    newInterestName.trimmingCharacters(
                                        in: .whitespacesAndNewlines
                                    )
                                guard !trimmed.isEmpty else { return }
                                let newItem = InterestModel(
                                    name: trimmed,
                                    icon: "star"
                                )
                                options.append(newItem)
                                interest = trimmed
                                dismiss()
                            }
                            .disabled(
                                newInterestName.trimmingCharacters(
                                    in: .whitespacesAndNewlines
                                ).isEmpty
                            )
                            .padding(.trailing, 14)
                        }
                        .background(Color(.tertiarySystemBackground))

                        Divider()
                    }

                    ForEach(options) { option in
                        Button {
                            interest = option.name
                            dismiss()
                        } label: {
                            HStack {
                                Image(systemName: option.icon)
                                    .frame(width: 24)
                                    .foregroundStyle(.secondary)

                                Text(option.name)
                                    .font(.system(size: 16))
                                    .foregroundStyle(.primary)

                                Spacer()

                                if interest.lowercased()
                                    == option.name.lowercased()
                                {
                                    Image(systemName: "checkmark")
                                        .font(.system(size: 12))
                                        .foregroundStyle(.accent)
                                }
                            }
                            .padding(.horizontal, 14)
                            .padding(.vertical, 11)
                            .contentShape(Rectangle())
                        }
                    }
                }
            }
            .navigationTitle("Interest")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .frame(width: 32, height: 32)
                            .background(.ultraThinMaterial)
                            .foregroundStyle(.primary)
                            .clipShape(Circle())
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            showAddField.toggle()
                            if !showAddField { newInterestName = "" }
                        }
                    } label: {
                        Image(
                            systemName: showAddField
                                ? "minus.circle" : "plus.circle"
                        )
                        .foregroundStyle(.accent)
                    }
                }

            }
        }

    }
}

#Preview {
    InterestSheet(
        interest: .constant("Test"),
        options: .constant(InterestModel.interests)
    )
}
