//
//  SidebarView.swift
//  Streakosaur
//
//  Created by Vsevolod Zaikov on 6/24/2025.
//

import SwiftUI

struct SidebarView: View {
    @Environment(\.openWindow) private var openWindow
    
    var body: some View {
        VStack {
            Spacer()
            
            Button {
                openWindow(id: "new-streak")
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "plus.circle")
                    
                    Text("Add Streak")
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    SidebarView()
}
