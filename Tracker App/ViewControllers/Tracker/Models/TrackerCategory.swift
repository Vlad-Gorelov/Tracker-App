//
//  TrackerCategory.swift
//  Tracker App
//
//  Created by Владислав Горелов on 23.01.2024.
//

import Foundation

struct TrackerCategory {
    let trackerTitle: String
    let trackers: [Tracker]

    init(trackerTitle: String, trackers: [Tracker]) {
        self.trackerTitle = trackerTitle
        self.trackers = trackers
    }
}
