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
        contacts: ContactsModel(
            WhatsApp: nil,
            Instagram: nil,
            Email: nil,
            Discord: nil
        )
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
            
                
                    /// WhatsApp Field
                    HStack {
                        Image("Whatsapp")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45, height: 45)
                            .clipShape(Circle())
                            .padding(.leading, 10)
                           
                            .padding(.top, 10)
                            .padding(.bottom, 10)

                        Divider().frame(height: 55)
                        TextField(
                            "WhatsApp Number",
                            text: Binding(
                                get: {
                                    newPerson.contacts.WhatsApp ?? ""
                                },
                                set: {
                                    newPerson.contacts.WhatsApp = $0
                                }
                            )
                        )
                
                    }.background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))


                    /// Discord Field
                HStack {
                    Image("Discord")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                        .background(Color(.white))
                        .clipShape(Circle())
                        .padding(.leading, 10)
          
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                    

                    Divider().frame(height: 55)
                    TextField(
                        "Discord Link",
                        text: Binding(
                            get: {
                                newPerson.contacts.Discord ?? ""
                            },
                            set: {
                                newPerson.contacts.Discord = $0
                            }
                        )
                    )
            
                }.background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                

                /// Mail Field
                HStack {
                    Image("Mail")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                        .padding(.leading, 10)
                        
                        .padding(.top, 10)
                        .padding(.bottom, 10)

                    Divider().frame(height: 55)
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
            
                }.background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))

                /// Instagram Field
                HStack {
                    Image("Instagram")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                        .padding(.leading, 10)
                        
                        .padding(.top, 10)
                        .padding(.bottom, 10)

                    Divider().frame(height: 55)
                    TextField(
                        "Discord Link",
                        text: Binding(
                            get: {
                                newPerson.contacts.Instagram ?? ""
                            },
                            set: {
                                newPerson.contacts.Instagram = $0
                            }
                        )
                    )
            
                }.background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
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
