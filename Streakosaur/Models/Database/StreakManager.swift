//
//  StreakManager.swift
//  Streakosaur
//
//  Created by Vsevolod Zaikov on 6/23/2025.
//
import GRDB

class StreakManager {
    private let dbQueue: DatabaseQueue
    
    init(path: String) throws {
        dbQueue = try DatabaseQueue(path: path)
        try MigrationManager.migrate(dbQueue)
    }
    
    func createStreak(_ streak: Streak) throws {
        try dbQueue.write { db in
            try streak.insert(db)
        }
    }
    
    func updateStreak(_ streak: Streak) throws {
        try dbQueue.write { db in
            try streak.update(db)
        }
    }
    
    func getAllStreaks() throws -> [Streak] {
        try dbQueue.read { db in
            try Streak.fetchAll(db)
        }
    }
}
