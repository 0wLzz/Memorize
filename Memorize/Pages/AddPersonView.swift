//
//  EditPersonView.swift
//  Memorize
//
//  Created by Owen Limantoro on 21/04/26.
//

import SwiftUI
import Photos
import PhotosUI

struct AddPersonView: View {
    @EnvironmentObject var repo: PersonRepository
    @Environment(\.dismiss) private var dismiss
    @State var newPerson = PersonModel(
        name: "",
        interest: InterestModel.interests[0],
        contacts: ContactsModel.contactsExample
    )
    
    func onSave(image: UIImage) {
        newPerson.profileImage = image
        repo.persons.append(newPerson)
    }
    
    var image: UIImage

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                /// Profile Edit
                Image(uiImage: image)
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .overlay {
                        Button {
                            print("Test")
                        } label: {
                            Circle()
                                .fill(Color.gray)
                                .frame(width: 50, height: 50)
                                .overlay {
                                    Image(systemName: "pencil")
                                        .font(
                                            .system(size: 24, weight: .medium)
                                        )
                                        .foregroundStyle(.white)
                                }
                        }
                        .offset(x: 75, y: 75)
                    }

                VStack(alignment: .leading, spacing: 4) {
                    Text("Name")
                        .font(.system(.headline, design: .rounded))

                    ZStack {
                        Rectangle()
                            .fill(.white)
                            .frame(width: .infinity, height: 35)
                            .overlay {
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color.gray, lineWidth: 1)

                                TextField("Name", text: $newPerson.name)
                                    .padding(8)
                            }
                    }
                }

                /// Interest Field
                VStack(alignment: .leading, spacing: 4) {
                    Text("Interest")
                        .font(.system(.headline, design: .rounded))

                    ZStack {
                        Rectangle()
                            .fill(.white)
                            .frame(width: .infinity, height: 35)
                            .overlay {
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color.gray, lineWidth: 1)

                                TextField(
                                    "Interest",
                                    text: $newPerson.interest.name
                                )
                                .padding(8)
                            }
                    }
                }

                /// Notes Field
                VStack(alignment: .leading, spacing: 4) {
                    Text("Notes")
                        .font(.system(.headline, design: .rounded))

                    ZStack {
                        Rectangle()
                            .fill(.white)
                            .frame(width: .infinity, height: 35)
                            .overlay {
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color.gray, lineWidth: 1)

                                TextField(
                                    "Notes",
                                    text: Binding(
                                        get: { newPerson.notes ?? "" },
                                        set: { newPerson.notes = $0 }
                                    )
                                )
                                .padding(8)
                            }
                    }
                }

                /// WhatsApp Field
                HStack {
                    Image("Whatsapp")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Whatsapp")
                            .font(.system(.headline, design: .rounded))

                        ZStack {
                            Rectangle()
                                .fill(.white)
                                .frame(width: .infinity, height: 35)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(Color.gray, lineWidth: 1)

                                    TextField(
                                        "Whatsapp Link",
                                        text: Binding(
                                            get: {
                                                newPerson.contacts.WhatsApp
                                                    ?? ""
                                            },
                                            set: {
                                                newPerson.contacts.WhatsApp = $0
                                            }
                                        )
                                    )
                                    .padding(8)
                                }
                        }
                    }
                }

                /// Discord Field
                HStack {
                    Image("Discord")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Discord")
                            .font(.system(.headline, design: .rounded))

                        ZStack {
                            Rectangle()
                                .fill(.white)
                                .frame(width: .infinity, height: 35)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(Color.gray, lineWidth: 1)

                                    TextField(
                                        "Discord Link",
                                        text: Binding(
                                            get: {
                                                newPerson.contacts.Discrod ?? ""
                                            },
                                            set: {
                                                newPerson.contacts.Discrod = $0
                                            }
                                        )
                                    )
                                    .padding(8)
                                }
                        }
                    }
                }

                /// Mail Field
                HStack {
                    Image("Mail")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Mail")
                            .font(.system(.headline, design: .rounded))

                        ZStack {
                            Rectangle()
                                .fill(.white)
                                .frame(width: .infinity, height: 35)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(Color.gray, lineWidth: 1)

                                    TextField(
                                        "Email",
                                        text: Binding(
                                            get: {
                                                newPerson.contacts.Email ?? ""
                                            },
                                            set: {
                                                newPerson.contacts.Email = $0
                                            }
                                        )
                                    )
                                    .padding(8)
                                }
                        }
                    }
                }

                /// Instagram Field
                HStack {
                    Image("Instagram")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Instagram")
                            .font(.system(.headline, design: .rounded))

                        ZStack {
                            Rectangle()
                                .fill(.white)
                                .frame(width: .infinity, height: 35)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(Color.gray, lineWidth: 1)

                                    TextField(
                                        "Instagram Link",
                                        text: Binding(
                                            get: {
                                                newPerson.contacts.Instagram
                                                    ?? ""
                                            },
                                            set: {
                                                newPerson.contacts.Instagram =
                                                    $0
                                            }
                                        )
                                    )
                                    .padding(8)
                                }
                        }
                    }
                }
            }
            .padding(16)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                        onSave(image: image
                        )
                    } label: {
                        Image(systemName: "checkmark")
                    }
                }
            }
        }

    }
}
