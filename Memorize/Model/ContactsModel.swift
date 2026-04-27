//
//  ContactsModel.swift
//  Memorize
//
//  Created by Owen Limantoro on 22/04/26.
//

import Foundation
import SwiftUI
import SwiftData

@Model
final class ContactsModel {
    var WhatsApp: String?
    var Instagram: String?
    var Email: String?
    var Discord: String?

    func openWhatsApp() {
        guard let number = WhatsApp,
              let url = URL(string: "https://wa.me/\(number)") else { return }
        UIApplication.shared.open(url)
    }

    func openInstagram() {
        guard let username = Instagram else { return }
        // Try app first, fall back to web
        let appURL = URL(string: "instagram://user?username=\(username)")!
        let webURL = URL(string: "https://instagram.com/\(username)")!
        if UIApplication.shared.canOpenURL(appURL) {
            UIApplication.shared.open(appURL)
        } else {
            UIApplication.shared.open(webURL)
        }
    }

    func openEmail() {
        guard let address = Email,
              let url = URL(string: "mailto:\(address)") else { return }
        UIApplication.shared.open(url)
    }

    func openDiscord() {
        guard let username = Discord else { return }
        // Discord doesn't have a direct user URL scheme by username;
        // best option is to open the app or their profile if you have a user ID
        let appURL = URL(string: "discord://")!
        let webURL = URL(string: "https://discord.com/users/\(username)")!
        if UIApplication.shared.canOpenURL(appURL) {
            UIApplication.shared.open(appURL)
        } else {
            UIApplication.shared.open(webURL)
        }
    }
    
    init(WhatsApp: String? = nil, Instagram: String? = nil, Email: String? = nil, Discord: String? = nil) {
        self.WhatsApp = WhatsApp
        self.Instagram = Instagram
        self.Email = Email
        self.Discord = Discord
    }
}
