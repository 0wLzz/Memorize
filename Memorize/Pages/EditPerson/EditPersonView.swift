//
//  EditPersonView.swift
//  Memorize
//
//  Created by Owen Limantoro on 21/04/26.
//

import SwiftUI

struct EditPersonView: View {
    @Binding var newPerson : PersonModel

    func dummyFunction() {
        print("Test")
    }

    var body: some View {
        ScrollView{
            VStack(spacing: 16){
                /// Profile Edit
                Image("Hans")
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
                                        .font(.system(size: 24, weight: .medium))
                                        .foregroundStyle(.white)
                                }
                        }
                        .offset(x: 75, y: 75)
                    }
                
                VStack (alignment: .leading, spacing: 4){
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
                VStack (alignment: .leading, spacing: 4){
                    Text("Interest")
                        .font(.system(.headline, design: .rounded))
                    
                    ZStack {
                        Rectangle()
                            .fill(.white)
                            .frame(width: .infinity, height: 35)
                            .overlay {
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color.gray, lineWidth: 1)
                                
                                TextField("Interest", text: $newPerson.name)
                                    .padding(8)
                            }
                    }
                }
                
                /// Notes Field
                VStack (alignment: .leading, spacing: 4){
                    Text("Notes")
                        .font(.system(.headline, design: .rounded))
                    
                    ZStack {
                        Rectangle()
                            .fill(.white)
                            .frame(width: .infinity, height: 35)
                            .overlay {
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color.gray, lineWidth: 1)
                                
                                TextField("Notes", text: $newPerson.notes)
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
                    
                    
                    VStack (alignment: .leading, spacing: 4){
                        Text("Whatsapp")
                            .font(.system(.headline, design: .rounded))
                        
                        ZStack {
                            Rectangle()
                                .fill(.white)
                                .frame(width: .infinity, height: 35)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(Color.gray, lineWidth: 1)
                                    
                                    TextField("Whatsapp Link", text: $newPerson.contacts.WhatsApp)
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
                    
                    
                    VStack (alignment: .leading, spacing: 4){
                        Text("Discord")
                            .font(.system(.headline, design: .rounded))
                        
                        ZStack {
                            Rectangle()
                                .fill(.white)
                                .frame(width: .infinity, height: 35)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(Color.gray, lineWidth: 1)
                                    
                                    TextField("Discord Link", text: $newPerson.contacts.Discrod)
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
                    
                    
                    VStack (alignment: .leading, spacing: 4){
                        Text("Mail")
                            .font(.system(.headline, design: .rounded))
                        
                        ZStack {
                            Rectangle()
                                .fill(.white)
                                .frame(width: .infinity, height: 35)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(Color.gray, lineWidth: 1)
                                    
                                    TextField("Mail", text: $newPerson.contacts.WhatsApp)
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
                    
                    
                    VStack (alignment: .leading, spacing: 4){
                        Text("Instagram")
                            .font(.system(.headline, design: .rounded))
                        
                        ZStack {
                            Rectangle()
                                .fill(.white)
                                .frame(width: .infinity, height: 35)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(Color.gray, lineWidth: 1)
                                    
                                    TextField("Instagram Link", text: $newPerson.contacts.Instagram)
                                        .padding(8)
                                }
                        }
                    }
                }
            }
            .padding(16)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dummyFunction()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                }
            }
        }

    }
}
