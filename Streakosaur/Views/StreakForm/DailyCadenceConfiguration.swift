//
//  DailyCadenceConfiguration.swift
//  Streakosaur
//
//  Created by Vsevolod Zaikov on 6/24/2025.
//

import SwiftUI

struct DailyCadenceConfiguration: View {
    @Binding var daysToAsk: Int
    @Binding var daysToSkip: Int
    
    var body: some View {
        Form {
            Picker("Days in a row to ask", selection: $daysToAsk) {
                Text("1").tag(1)
                Text("2").tag(2)
                Text("3").tag(3)
                Text("4").tag(4)
                Text("5").tag(5)
            }.pickerStyle(.segmented)
            
            Picker("Days in a row to skip", selection: $daysToSkip) {
                Text("0").tag(0)
                Text("1").tag(1)
                Text("2").tag(2)
                Text("3").tag(3)
                Text("4").tag(4)
                Text("5").tag(5)
            }.pickerStyle(.segmented)
        }
    }
}
