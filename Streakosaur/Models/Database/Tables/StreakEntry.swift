//
//  StreakEntry.swift
//  Streakosaur
//
//  Created by Vsevolod Zaikov on 6/23/2025.
//
import Foundation
import GRDB

struct StreakEntry: Codable {
    var id: String
    var streakCadenceId: String
    var success: Bool
    var date: Date
}

extension StreakEntry: FetchableRecord, PersistableRecord, TableRecord {
    static let databaseTableName = "streak_entries"
    
    enum Columns {
        case id, streakCadenceId, success, date
    }
    
    static let cadence = belongsTo(StreakCadence.self)
}

extension StreakEntry {
    enum CodingKeys: String, CodingKey, ColumnExpression {
        case id, streakCadenceId, success, date
    }
}
