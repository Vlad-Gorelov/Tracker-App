//
//  Tracker.swift
//  Tracker App
//
//  Created by Владислав Горелов on 23.01.2024.
//

import UIKit

struct Tracker {
    let id: UUID
    let name: String
    let color: UIColor
    let emoji: String
    let schedule: [WeekDay]

    init(name: String, color: UIColor, emoji: String, schedule: [WeekDay]) {
        self.id = UUID()
        self.name = name
        self.color = color
        self.emoji = emoji
        self.schedule = schedule
    }
}
