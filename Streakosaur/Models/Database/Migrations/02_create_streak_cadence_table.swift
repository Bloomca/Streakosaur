//
//  02_create_streak_cadence_table.swift
//  Streakosaur
//
//  Created by Vsevolod Zaikov on 6/23/2025.
//
import GRDB

struct Migration_02_CreateStreakCadencesTable: DatabaseMigration {
    static let identifier = "02_create_streak_cadences_table"
    
    static func migrate(_ db: Database) throws {
        try db.create(table: "streak_cadences") { t in
            t.column("id", .text).primaryKey()
            t.column("streakId", .text).notNull().references("streaks", onDelete: .cascade)
            t.column("cadenceType", .text).notNull()
            t.column("cadenceValue", .text).notNull()
            t.column("startDate", .datetime).notNull()
            t.column("endDate", .datetime)
        }
    }
}
