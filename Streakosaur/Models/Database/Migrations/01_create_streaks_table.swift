//
//  01_create_streaks_table.swift
//  Streakosaur
//
//  Created by Vsevolod Zaikov on 6/23/2025.
//
import GRDB

struct Migration_01_CreateStreaksTable: DatabaseMigration {
    static let identifier = "01_create_streaks_table"
    
    static func migrate(_ db: Database) throws {
        try db.create(table: "streaks") { t in
            t.column("id", .text).primaryKey()
            t.column("title", .text).notNull()
            t.column("description", .text).notNull()
            t.column("targetRate", .integer).notNull()
        }
    }
}
