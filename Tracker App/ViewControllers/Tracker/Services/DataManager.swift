//
//  DataManager.swift
//  Tracker App
//
//  Created by Владислав Горелов on 08.02.2024.
//

import Foundation

class DataManager {
    static let shared = DataManager()

    var categories: [TrackerCategory] = [
        TrackerCategory(
            trackerTitle: "Домашний уют",
            trackers: [
                Tracker(
                    id: UUID(),
                    name: "Поливать растения",
                    color: .colorSelection18,
                    emoji: "❤",
                    schedule: [WeekDay.wednesday, WeekDay.sunday, WeekDay.tuesday, WeekDay.friday]
                )
            ]),
        TrackerCategory(
            trackerTitle: "Радостные мелочи",
            trackers: [
                Tracker(
                    id: UUID(),
                    name: "Кошка заслонила камеру на созвоне",
                    color: .colorSelection2,
                    emoji: "😻",
                    schedule: [WeekDay.tuesday, WeekDay.friday]
                ),
                Tracker(
                    id: UUID(),
                    name: "Бабушка прислала открытку в вотсапе",
                    color: .colorSelection1,
                    emoji: "🌺",
                    schedule: [WeekDay.monday, WeekDay.wednesday, WeekDay.friday]
                ),
                Tracker(
                    id: UUID(),
                    name: "Свидания в апреле",
                    color: .colorSelection14,
                    emoji: "❤",
                    schedule: [WeekDay.saturday, WeekDay.sunday]
                )
            ])
    ]

    private init() {}
}
