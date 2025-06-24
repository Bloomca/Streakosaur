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
        }
    }
}
