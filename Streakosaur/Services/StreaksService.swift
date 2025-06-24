//
//  StreaksService.swift
//  Streakosaur
//
//  Created by Vsevolod Zaikov on 6/23/2025.
//
import Foundation

@Observable class StreaksService {
    private let streakManager: StreakManager
    
    init() {
        let appSupportURL = FileManager
            .default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        let dbURL = appSupportURL.appendingPathComponent("YourAppName/database.sqlite")
        
        do {
            try FileManager.default.createDirectory(at: dbURL.deletingLastPathComponent(),
                                                  withIntermediateDirectories: true)

            streakManager = try StreakManager(path: dbURL.path)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
