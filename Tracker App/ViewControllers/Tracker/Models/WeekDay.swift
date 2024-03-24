//
//  WeekDay.swift
//  Tracker App
//
//  Created by Владислав Горелов on 23.01.2024.
//

import Foundation

let calendar = Calendar(identifier: .gregorian)

struct WeekDay: OptionSet {
    let rawValue: Int

    static let sunday    = WeekDay(rawValue: 1 << 0)
    static let monday  = WeekDay(rawValue: 1 << 1)
    static let tuesday   = WeekDay(rawValue: 1 << 2)
    static let wednesday   = WeekDay(rawValue: 1 << 3)
    static let thursday   = WeekDay(rawValue: 1 << 4)
    static let friday   = WeekDay(rawValue: 1 << 5)
    static let saturday   = WeekDay(rawValue: 1 << 6)


    static func from(date: Date) -> WeekDay? {
        guard let dayNum = calendar.dateComponents([.weekday], from: date).weekday else {
            return nil // Обработка ситуации, когда день недели не определен
        }
        let dayValue = 1 << (dayNum - 1)  // сдвиг 1 по битовым разрядам. это возведение 2 в степень
        return WeekDay(rawValue: dayValue)
    }


    func asText() -> String {
        switch self {
        case .monday:
            return "Понедельник"
        case .tuesday:
            return "Вторник"
        case .wednesday:
            return "Среда"
        case .thursday:
            return "Четверг"
        case .friday:
            return "Пятница"
        case .saturday:
            return "Суббота"
        case .sunday:
            return "Воскресенье"
        default:
            let week: [WeekDay] = [.sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday ]
            return week
                .filter { day in self.contains(day) }
                .map({ day in day.asText()})
                .joined(separator: ", ")
        }
    }

    func asShortText() -> String {
        switch self {
        case .monday:
            return "Пн"
        case .tuesday:
            return "Вт"
        case .wednesday:
            return "Ср"
        case .thursday:
            return "Чт"
        case .friday:
            return "Пт"
        case .saturday:
            return "Сб"
        case .sunday:
            return "Вс"
        default:
            let week: [WeekDay] = [ .sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday]
            return week
                .filter { day in self.contains(day) }
                .map({ day in day.asShortText()})
                .joined(separator: ", ")
        }
    }
}
