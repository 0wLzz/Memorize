//
//  BirthdayModel.swift
//  Memorize
//  Model for birthdays
//  Created by Hans Hartowidjojo on 15/07/26.
//

import Foundation

struct BirthdayModel: Codable {
    var date: Date
    var reminderEnabled: Bool = false
}
