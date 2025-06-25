//
//  StreaksService.swift
//  Streakosaur
//
//  Created by Vsevolod Zaikov on 6/23/2025.
//
import Foundation

@Observable final class StreaksService {
    private let streakManager: StreakManager
    
    init(streakManager: StreakManager) {
        self.streakManager = streakManager
    }
    
    public func getAllStreaks() throws -> [Streak] {
        try streakManager.getAllStreaks()
    }
    
    public func getStreak(id: String) throws -> Streak? {
        try streakManager.getSingleStreak(id: id)
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
