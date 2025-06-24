//
//  StreaksService.swift
//  Streakosaur
//
//  Created by Vsevolod Zaikov on 6/23/2025.
//
import Foundation

@Observable class StreaksService {
    private let streakManager: StreakManager
    
    init() {
        let appSupportURL = FileManager
            .default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        let dbURL = appSupportURL.appendingPathComponent("YourAppName/database.sqlite")
        
        do {
            try FileManager.default.createDirectory(at: dbURL.deletingLastPathComponent(),
                                                  withIntermediateDirectories: true)

            streakManager = try StreakManager(path: dbURL.path)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    public func createStreak(title: String, description: String, targetRate: Int, cadence: Cadence) -> Bool {
        let newStreakId = UUID().uuidString
        let newStreak = Streak(id: newStreakId, title: title, description: description, targetRate: targetRate)
        
        /// TODO: switch to a transaction
        do {
            try streakManager.createStreak(newStreak)
            let newStreakCadence = StreakCadence(from: cadence, streakId: newStreakId)
            try streakManager.createStreakCadence(newStreakCadence)
            
            return true
        } catch {
            print(error)
            return false
        }
    }
}
