//
//  Occurrence.swift
//  Streakosaur
//
//  Created by Vsevolod Zaikov on 6/25/2025.
//
import Foundation

enum OccurrenceType {
    case past
    case current
    case future
}

struct Occurrence: Identifiable {
    var id = UUID()
    var type: OccurrenceType
    var date: Date
    var marked: Bool
}
