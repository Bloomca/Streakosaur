//
//  Cadence.swift
//  Streakosaur
//
//  Created by Vsevolod Zaikov on 6/23/2025.
//

/// To conform to SwiftUI Picker component
enum CadenceType {
    case daily
    case weekly
    case days
}

enum Cadence: Codable {
    case daily(Int, Int) // how many days in a row to ask, and how many days in a row to skip
    case weekly(Int, Int) // how many weeks in a row to ask, and how many weeks in a row to skip
    case days([Days]) // ask only on specific days (e.g. monday + thursday + friday)
}

enum Days: String, Codable {
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"
    case sunday = "Sunday"
}
