//
//  SidebarView.swift
//  Streakosaur
//
//  Created by Vsevolod Zaikov on 6/24/2025.
//

import SwiftUI

struct SidebarView: View {
    @Environment(\.openWindow) private var openWindow
    @Environment(AppStateVM.self) private var appStateVM
    
    var body: some View {
        @Bindable var vm = appStateVM
        
        VStack(spacing: 0) {
            Spacer()
            
            List(vm.streaks, selection: $vm.selectedStreak) { streak in
                Label(streak.title, systemImage: "list.star").tag(streak.id)
            }
            
            Button {
                openWindow(id: "new-streak")
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "plus.circle")
                    
                    Text("Add Streak")
                }
                .padding(4)
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom, 12)
        }
    }
}
