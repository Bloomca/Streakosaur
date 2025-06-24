//
//  ContentView.swift
//  Streakosaur
//
//  Created by Vsevolod Zaikov on 6/23/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationSplitView(sidebar: {
            SidebarView()
        }, detail: {
            Text("Detail")
        })
    }
}

#Preview {
    ContentView()
}
