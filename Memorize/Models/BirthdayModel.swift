//
//  BirthdayModel.swift
//  Memorize
//
//  Created by Hans Hartowidjojo on 16/07/26.
//
import Foundation

struct BirthdayModel: Codable {
    var date: Date
    var reminderEnabled: Bool = false
}
