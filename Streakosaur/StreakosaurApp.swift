//
//  StreakosaurApp.swift
//  Streakosaur
//
//  Created by Vsevolod Zaikov on 6/23/2025.
//

import SwiftUI

@main
struct StreakosaurApp: App {
    let streaksService = StreaksService()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(streaksService)
        }
    }
}
