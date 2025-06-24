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
    
    var explanation: String {
        let prefix = "Ask for an update "
        
        /// if we are not skipping any days, it means we'll ask every day regardless
        if daysToSkip == 0 {
            return prefix + "every day"
        }
        
        if daysToAsk == 1 {
            if daysToSkip == 1 {
                return prefix + "every other day"
            } else {
                /// e.g. 2 days to skip: 1 day to ask, 2 to skip = 3 days total
                return prefix + "every \(daysToSkip + 1) days"
            }
        }
        
        return prefix + "every \(daysToAsk) days, and then skip \(daysToSkip) \(daysToSkip == 1 ? "day" : "days")"
    }
    
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
            
            if !explanation.isEmpty {
                Text(explanation)
                    .italic()
                    .foregroundStyle(.secondary)
            }
        }
    }
}
