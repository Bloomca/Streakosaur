//
//  Streak.swift
//  Streakosaur
//
//  Created by Vsevolod Zaikov on 6/23/2025.
//
import GRDB

struct Streak: Codable, Identifiable {
    var id: String
    var title: String
    var description: String
    var targetRate: Int // min: 0, max: 100
}

extension Streak: FetchableRecord, PersistableRecord, TableRecord {
    static let databaseTableName = "streaks"
    
    enum Columns {
        case id, title, description, targetRate
    }
    
    static let cadences = hasMany(StreakCadence.self)
}
