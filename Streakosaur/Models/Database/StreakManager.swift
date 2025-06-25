//
//  StreakManager.swift
//  Streakosaur
//
//  Created by Vsevolod Zaikov on 6/23/2025.
//
import Foundation
import GRDB

class StreakManager {
    private let dbQueue: DatabaseQueue
    
    static func createManager() -> StreakManager {
        let appSupportURL = FileManager
            .default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        let dbURL = appSupportURL.appendingPathComponent("YourAppName/database.sqlite")
        
        do {
            try FileManager.default.createDirectory(at: dbURL.deletingLastPathComponent(),
                                                  withIntermediateDirectories: true)

            let streakManager = try StreakManager(path: dbURL.path)
            
            return streakManager
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    init(path: String) throws {
        dbQueue = try DatabaseQueue(path: path)
        try MigrationManager.migrate(dbQueue)
    }
    
    func createStreak(_ streak: Streak) throws {
        try dbQueue.write { db in
            try streak.insert(db)
        }
    }
    
    func createStreakCadence(_ streakCadence: StreakCadence) throws {
        try dbQueue.write { db in
            try streakCadence.insert(db)
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
    
    func getSingleStreak(id: String) throws -> Streak? {
        try dbQueue.read { db in
            try Streak.fetchOne(db, key: id)
        }
    }
    
    func getCurrentStreakCadence(streakId: String) throws -> StreakCadence? {
        try dbQueue.read { db in
            try StreakCadence
                .filter(StreakCadence.CodingKeys.streakId == streakId)
                .filter(StreakCadence.CodingKeys.endDate == nil)
                .fetchOne(db)
        }
    }
    
    func getLatestStreakEntry(streakCadenceId: String) throws -> StreakEntry? {
        try dbQueue.read { db in
            try StreakEntry
                .filter(StreakEntry.CodingKeys.streakCadenceId == streakCadenceId)
                .order(StreakEntry.CodingKeys.date.desc)
                .limit(1)
                .fetchOne(db)
        }
    }
}
