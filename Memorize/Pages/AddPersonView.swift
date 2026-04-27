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
    @State var text: String = ""
    @State private var showList: Bool = false

    @State var newPerson = PersonModel(
        name: "",
        imageName: "",
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
                    .resizable()
                    .scaledToFill()
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
                VStack{

                        TextField("What's their name?", text: $newPerson.name)
    
                   .padding(18)
                    Divider()
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: Binding(
                            get: { newPerson.notes ?? "" },
                            set: { newPerson.notes = $0 }
                        ))
                        .frame(height: 100)
                        .scrollContentBackground(.hidden)
                        .background(Color(.secondarySystemBackground))
                        .padding(.leading, )

                        if (newPerson.notes ?? "").isEmpty {
                            Text("Notes")
                                .font(.system(.callout, design: .rounded))
                                .foregroundColor(Color(.placeholderText))
                                .padding(.top, 8)
                                .padding(.leading, 18)
                                .allowsHitTesting(false) // 👈 lets taps pass through to TextEditor
                        }
                    }

                }.background(Color(.secondarySystemBackground))
                    
                    .cornerRadius(15)
                
                

                /// Interest Field
                HStack {
                    Text("Interest")
            
                    Divider()
                        .frame(height: 24)
                    
                    Text(text == "" ? "Select or add new" : text)
                        .foregroundStyle(.accent)
                        .onTapGesture {
                            showList = true
                        }
                        .onChange(of: text) { _, newValue in
                            if let match = repo.interests.first(where: { $0.name == newValue }) {
                                newPerson.interest = match
                            }
                        }

                    Spacer()
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .sheet(isPresented: $showList) {
                    InterestSheet(text: $text, options: $repo.interests)
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

#Preview {
    AddPersonView(image: UIImage(systemName: "person.fill")!)
        .environmentObject(PersonRepository())
}
