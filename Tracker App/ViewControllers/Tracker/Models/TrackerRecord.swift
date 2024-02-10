//
//  TrackerCategory.swift
//  Tracker App
//
//  Created by Владислав Горелов on 23.01.2024.
//

import Foundation

struct TrackerRecord {
    let id: UUID
    let trackerID: UUID
    let date: Date

    init(trackerID: UUID, date: Date) {
        self.id = UUID()
        self.trackerID = trackerID
        self.date = date
    }
}
