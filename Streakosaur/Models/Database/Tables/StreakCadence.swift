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

extension StreakCadence {
    init(from cadence: Cadence, streakId: String) {
        self.id = UUID().uuidString
        self.streakId = streakId
        
        switch cadence {
        case .daily(let daysToAsk, let daysToSkip):
            self.cadenceType = "daily"
            self.cadenceValue = "\(daysToAsk),\(daysToSkip)"
        case .weekly(let weeksToAsk, let weeksToSkip):
            self.cadenceType = "weekly"
            self.cadenceValue = "\(weeksToAsk),\(weeksToSkip)"
        case .days(let days):
            self.cadenceType = "days"
            self.cadenceValue = days.map({ $0.rawValue }).joined(separator: ",")
        }
        
        self.startDate = Date()
    }
}
