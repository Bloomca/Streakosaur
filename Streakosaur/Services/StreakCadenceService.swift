//
//  StreakCadenceService.swift
//  Streakosaur
//
//  Created by Vsevolod Zaikov on 6/24/2025.
//
import Foundation

@Observable
final class StreakCadenceService {
    private let streakManager: StreakManager
    
    init(streakManager: StreakManager) {
        self.streakManager = streakManager
    }
    
    func calculateNextOccurences(streakId: String) -> [Occurrence] {
        /**
         1. Get current (active) streak cadence
         2. Calculate cycle length (active days + skip)
         3. Calculate current cycle beginning based on the (has to be in the past)
         4. Calculate all checks for this cycle (potentially the next cycle as well)
         5. Get the last Streak Entry and compare to the calculated checks
         6. If needed, go into the past until we find all necessary missing entries
         */
        
        do {
            guard let currentStreakCadence = try streakManager.getCurrentStreakCadence(streakId: streakId) else {
                print("There is no current streak cadence somehow")
                return []
            }
            
            /// Not guarding -- if this is a new streak cadence, it won't have any entries associated with it
            let latestStreakEntry = try streakManager.getLatestStreakEntry(streakCadenceId: currentStreakCadence.id)
            
            guard let cycleLength = calculateCycleLength(streakCadence: currentStreakCadence) else {
                print("Could not calculate cycle length somehow")
                return []
            }
            
            /// if there is no latest streak entry, we don't need to calculate current cycle
            if let latestStreakEntry {
                let timeSince = latestStreakEntry.date.timeIntervalSince(currentStreakCadence.startDate)
                let cycles = round(timeSince / Double(cycleLength))
                let startCycle = currentStreakCadence.startDate.addingTimeInterval(Double(cycleLength) * cycles)
                
                return getClosestOccurrences(
                    startCycle: startCycle,
                    cycleLength: cycleLength,
                    streakCadence: currentStreakCadence
                )
            } else {
                return getClosestOccurrences(
                    startCycle: currentStreakCadence.startDate,
                    cycleLength: cycleLength,
                    streakCadence: currentStreakCadence
                )
            }
            
        } catch {
            print(error)
            return []
        }
    }
    
    /// Calculate cycle length in milliseconds
    /// if the type is incorrect, return nil (TODO: mark that data needs to be repaired)
    private func calculateCycleLength(streakCadence: StreakCadence) -> Int? {
        let DAY_LENGTH = 24 * 60 * 60
        let WEEK_LENTGH = 7 * DAY_LENGTH
        
        switch streakCadence.cadence {
        case .daily(let daysToAsk, let daysToSkip):
            if daysToSkip == 0 {
                return DAY_LENGTH
            } else {
                return (DAY_LENGTH * (daysToAsk + daysToSkip))
            }
        case .weekly(let weeksToAsk, let weeksToSkip):
            if weeksToSkip == 0 {
                return WEEK_LENTGH
            } else {
                return (WEEK_LENTGH * (weeksToAsk + weeksToSkip))
            }
        case .days:
            return WEEK_LENTGH
        }
    }
    
    private func getClosestOccurrences(startCycle: Date, cycleLength: Int, streakCadence: StreakCadence) -> [Occurrence] {
        switch streakCadence.cadence {
        case .daily(let daysToAsk, let daysToSkip):
            return getIntervalOccurrences(
                startCycle: startCycle,
                cycleLength: cycleLength,
                intervalsToAsk: daysToAsk,
                intervalLength: 24 * 60 * 60
            )
        case .weekly(let weeksToAsk, _):
            return getIntervalOccurrences(
                startCycle: startCycle,
                cycleLength: cycleLength,
                intervalsToAsk: weeksToAsk,
                intervalLength: 24 * 60 * 60 * 7
            )
        case .days(let days):
            return getDaysOccurrences(startCycle: startCycle, days: days)
        }
    }
    
    private func getIntervalOccurrences(
        startCycle: Date,
        cycleLength: Int,
        intervalsToAsk: Int,
        intervalLength: Int
    ) -> [Occurrence] {
        var occurrences: [Occurrence] = []
        var referenceDate = Date()
        var date = startCycle
        for i in 1...intervalsToAsk {
            if date > referenceDate {
                occurrences.append(Occurrence(type: .future, date: date, marked: false))
            } else {
                let isLast = i == intervalsToAsk
                if !isLast {
                    if date.addingTimeInterval(Double(intervalLength)) > referenceDate {
                        occurrences.append(Occurrence(type: .current, date: date, marked: false))
                    } else {
                        occurrences.append(Occurrence(type: .past, date: date, marked: false))
                    }
                } else {
                    if startCycle.addingTimeInterval(Double(cycleLength)) > referenceDate {
                        occurrences.append(Occurrence(type: .current, date: date, marked: false))
                    } else {
                        occurrences.append(Occurrence(type: .past, date: date, marked: false))
                    }
                }
            }
            
            date.addTimeInterval(Double(intervalLength))
        }
        
        return occurrences
    }
    
    private func getDaysOccurrences(startCycle: Date, days: [Days]) -> [Occurrence] {
        var occurrences: [Occurrence] = []
        var referenceDate = Date()
        
        return occurrences
    }
}
