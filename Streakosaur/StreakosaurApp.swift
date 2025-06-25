//
//  StreakosaurApp.swift
//  Streakosaur
//
//  Created by Vsevolod Zaikov on 6/23/2025.
//

import SwiftUI

@main
struct StreakosaurApp: App {
    let streaksService: StreaksService
    let streakCadenceService: StreakCadenceService
    let appStateVM: AppStateVM
    
    init() {
        let streakManager = StreakManager.createManager()
        streaksService = StreaksService(streakManager: streakManager)
        streakCadenceService = StreakCadenceService(streakManager: streakManager)
        appStateVM = AppStateVM(streaksService: streaksService)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(streaksService)
                .environment(appStateVM)
                .environment(streakCadenceService)
        }
        
        WindowGroup("New Streak", id: "new-streak") {
            StreakViewForm()
                .environment(streaksService)
                .frame(width: 400, height: 400)
        }
    }
}
