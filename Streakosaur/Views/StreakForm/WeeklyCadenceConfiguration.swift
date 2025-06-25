//
//  WeeklyCadenceConfiguration.swift
//  Streakosaur
//
//  Created by Vsevolod Zaikov on 6/24/2025.
//

import SwiftUI

struct WeeklyCadenceConfiguration: View {
    @Binding var weeksToAsk: Int
    @Binding var weeksToSkip: Int
    
    var explanation: String {
        let prefix = "Ask for an update "
        
        /// if we are not skipping any days, it means we'll ask every day regardless
        if weeksToSkip == 0 {
            return prefix + "every week"
        }
        
        if weeksToAsk == 1 {
            if weeksToSkip == 1 {
                return prefix + "every other week"
            } else {
                /// e.g. 2 weeks to skip: 1 week to ask, 2 to skip = 3 weeks total
                return prefix + "every \(weeksToSkip + 1) weeks"
            }
        }
        
        return prefix + "every \(weeksToAsk) weeks, and then skip \(weeksToSkip) \(weeksToSkip == 1 ? "week" : "weeks")"
    }
    
    var body: some View {
        Form {
            Picker("Weeks in a row to ask", selection: $weeksToAsk) {
                Text("1").tag(1)
                Text("2").tag(2)
                Text("3").tag(3)
                Text("4").tag(4)
                Text("5").tag(5)
            }.pickerStyle(.segmented)
            
            Picker("Weeks in a row to skip", selection: $weeksToSkip) {
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
