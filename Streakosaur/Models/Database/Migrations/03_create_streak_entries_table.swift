//
//  03_create_streak_entries_table.swift
//  Streakosaur
//
//  Created by Vsevolod Zaikov on 6/23/2025.
//
import GRDB

struct Migration_03_CreateStreakEntriesTable: DatabaseMigration {
    static let identifier = "03_create_streak_entries_table"
    
    static func migrate(_ db: Database) throws {
        try db.create(table: "streak_entries") { t in
            t.column("id", .text).primaryKey()
            t.column("streakCadenceId", .text).notNull().references("streak_cadences", onDelete: .cascade)
            t.column("success", .boolean).notNull()
            t.column("date", .datetime).notNull()
        }
    }
}
