//
//  ContentView.swift
//  Streakosaur
//
//  Created by Vsevolod Zaikov on 6/23/2025.
//

import SwiftUI

struct ContentView: View {
    @Environment(AppStateVM.self) var appStateVM
    
    var body: some View {
        NavigationSplitView(sidebar: {
            SidebarView()
        }, detail: {
            if let streakId = appStateVM.selectedStreak {
                StreakView(streakId: streakId)
            }
        })
    }
}
