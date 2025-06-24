//
//  DaysCadenceConfiguration.swift
//  Streakosaur
//
//  Created by Vsevolod Zaikov on 6/24/2025.
//

import SwiftUI

struct DaysCadenceConfiguration: View {
    @Binding var selectedDays: Set<Days>
    
    let weekdays: [Days] = [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday]

    var body: some View {
        VStack {
            HStack {
                ForEach(weekdays, id: \.self.rawValue) { day in
                    Button(day.rawValue.prefix(3)) {
                        print("Before: \(selectedDays)")
                        if selectedDays.contains(day) {
                            if selectedDays.count > 1 {
                                selectedDays.remove(day)
                            }
                        } else {
                            selectedDays.insert(day)
                        }
                        
                        print("After: \(selectedDays)")
                    }
                    .background(selectedDays.contains(day) ? Color.accentColor : Color.clear)
                    .foregroundColor(selectedDays.contains(day) ? .white : .primary)
                    .buttonStyle(.bordered)
                    .cornerRadius(6)
                }
            }
        }
    }
}
