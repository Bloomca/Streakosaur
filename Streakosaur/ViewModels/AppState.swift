//
//  AppState.swift
//  Streakosaur
//
//  Created by Vsevolod Zaikov on 6/24/2025.
//
import SwiftUI

@Observable
final class AppStateVM {
    private(set) var streaks: [Streak] = []
    private(set) var error: StreaksError?
    
    var selectedStreak: Streak.ID?
    
    private let streaksService: StreaksService
    
    init(streaksService: StreaksService) {
        self.streaksService = streaksService
        
        /// the app needs to read streaks anyway, so it is okay to read right away
        loadStreaks()
    }
    
    func loadStreaks() {
        do {
            streaks = try streaksService.getAllStreaks()
            print(streaks.count)
        } catch {
            print(error)
            self.error = StreaksError.couldNotLoad
        }
    }
}
