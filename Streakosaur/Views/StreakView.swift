//
//  StreakView.swift
//  Streakosaur
//
//  Created by Vsevolod Zaikov on 6/24/2025.
//

import SwiftUI

struct StreakView: View {
    @Environment(StreaksService.self) var streaksService
    @Environment(StreakCadenceService.self) var streakCadenceService
    
    @State var streak: Streak?
    @State var error: StreaksError?
    @State var occurrences: [Occurrence]?
    
    var streakId: String
    
    var body: some View {
        VStack {
            if let streak {
                Text(streak.title).font(.title)
                
                if !streak.description.isEmpty {
                    Text(streak.description).font(.caption)
                }
                
                if let occurrences {
                    ForEach(occurrences) { occurrence in
                        HStack {
                            Text(formatStreakDate(occurrence.date))
                            
                            Button {
                                //
                            } label: {
                                Text("Miss this instance")
                            }
                            .disabled(occurrence.type == .future)
                            
                            Button {
                                
                            } label: {
                                Text("Complete this instance")
                            }
                            .disabled(occurrence.type == .future)
                        }
                    }
                }
            } else {
                Text("Could not get the streak")
            }
        }
        .onAppear { loadStreak() }
        .onChange(of: streakId) { _, newValue in
            loadStreak()
        }
    }
    
    private func formatStreakDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .none
        formatter.setLocalizedDateFormatFromTemplate("Md")
        return formatter.string(from: date)
    }
    
    private func loadStreak() {
        do {
            self.streak = try streaksService.getStreak(id: streakId)
            
            let occurrences = streakCadenceService.calculateNextOccurences(streakId: streakId)
            self.occurrences = occurrences
        } catch {
            print(error)
            self.error = .couldNotLoad
        }
    }
}
