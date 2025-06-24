//
//  StreakViewForm.swift
//  Streakosaur
//
//  Created by Vsevolod Zaikov on 6/24/2025.
//

import SwiftUI

struct StreakViewForm: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(StreaksService.self) private var streaksService
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var targetRate = 75.0
    @State private var cadenceType: CadenceType = .daily
    
    /// state for daily cadence settings
    @State private var daysToAsk = 1
    @State private var daysToSkip = 0
    
    /// state for weekly cadence settings
    @State private var weeksToAsk = 1
    @State private var weeksToSkip = 0
    
    /// state for specific days cadence settings
    @State private var selectedDays: Set<Days> = [.monday, .tuesday, .wednesday, .thursday, .friday] {
        didSet {
            print("selectedDays did change: \(selectedDays)")
        }
    }
        
    var isDisabled: Bool {
        if title.isEmpty {
            return true
        }
        
        return false
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Add a new streak").font(.title)
            
            Form {
                TextField("Streak Name:", text: $title)
                TextField("Description (optional)", text: $description)
                
                VStack {
                    Slider(value: $targetRate, in: 1...100)
                    Text("Target rate: \(Int(targetRate))%")
                }
            
                Picker("Select Frequency", selection: $cadenceType) {
                    Text("Daily").tag(CadenceType.daily)
                    Text("Weekly").tag(CadenceType.weekly)
                    Text("Specific Days").tag(CadenceType.days)
                }
                .pickerStyle(.menu)
                
                switch cadenceType {
                case .daily:
                    DailyCadenceConfiguration(daysToAsk: $daysToAsk, daysToSkip: $daysToSkip)
                case .weekly:
                    WeeklyCadenceConfiguration(weeksToAsk: $weeksToAsk, weeksToSkip: $weeksToSkip)
                case .days:
                    VStack {
                        DaysCadenceConfiguration(selectedDays: $selectedDays)
                    }
                    /// this is crucial, otherwise SwiftUI does not correctly registers updates
                    /// in the child View. It can also be solved if there is any dependency on
                    /// selectedDays in this component, but this is more reliable
                    .id(selectedDays.hashValue)
                }
                
                HStack {
                    Button {
                        createStreak()
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .padding(4)
                    }
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Add New Streak")
                            .padding(4)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(isDisabled)
                }
            }
        }
        .padding()
        .frame(minHeight: 500)
    }
    
    private func createStreak() {
        
    }
}

#Preview {
    StreakViewForm()
}
