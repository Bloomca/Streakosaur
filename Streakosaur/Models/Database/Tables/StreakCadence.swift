//
//  StreakCadence.swift
//  Streakosaur
//
//  Created by Vsevolod Zaikov on 6/23/2025.
//
import Foundation
import GRDB

struct StreakCadence: Codable, Identifiable {
    var id: String
    var streakId: String
    var cadenceType: String
    var cadenceValue: String
    var startDate: Date
    var endDate: Date?
}

extension StreakCadence: FetchableRecord, PersistableRecord, TableRecord {
    static let databaseTableName = "streak_cadences"
    
    enum Columns {
        case id, streakId, cadenceType, cadenceValue, startDate, endDate
    }
    
    static let streak = belongsTo(Streak.self)
}
