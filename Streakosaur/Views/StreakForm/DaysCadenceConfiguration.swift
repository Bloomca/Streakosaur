//
//  DaysCadenceConfiguration.swift
//  Streakosaur
//
//  Created by Vsevolod Zaikov on 6/24/2025.
//

import SwiftUI

struct DaysCadenceConfiguration: View {
    @Binding var selectedDays: Set<String>
    
    /// hardcoded values, but this component is highly tied to the form, so it should be okay
    let weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

    var body: some View {
        VStack {
            HStack {
                ForEach(weekdays, id: \.self) { day in
                    Button(day.prefix(3)) {
                        if selectedDays.contains(day) {
                            if selectedDays.count > 1 {
                                selectedDays.remove(day)
                            }
                        } else {
                            selectedDays.insert(day)
                        }
                    }
                    .buttonStyle(.bordered)
                    .background(selectedDays.contains(day) ? Color.accentColor : Color.clear)
                    .cornerRadius(6)
                }
            }
        }
    }
}
