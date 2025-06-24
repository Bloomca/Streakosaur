//
//  MigrationManager.swift
//  Streakosaur
//
//  Created by Vsevolod Zaikov on 6/23/2025.
//
import GRDB

protocol DatabaseMigration {
    static var identifier: String { get }
    static func migrate(_ db: Database) throws
}

class MigrationManager {
    private static let migrations: [DatabaseMigration.Type] = [
        Migration_01_CreateStreaksTable.self,
        Migration_02_CreateStreakCadencesTable.self,
        Migration_03_CreateStreakEntriesTable.self
    ]
    
    static func createMigrator() -> DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
        for migration in migrations {
            migrator.registerMigration(migration.identifier) { db in
                try migration.migrate(db)
            }
        }
        
        return migrator
    }
    
    static func migrate(_ dbQueue: DatabaseQueue) throws {
        let migrator = createMigrator()
        try migrator.migrate(dbQueue)
    }
}
