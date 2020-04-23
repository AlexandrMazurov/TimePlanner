//
//  Date+Time.swift
//  TimePlannerApp
//
//  Created by Mazurov, Aleksandr on 4/20/20.
//  Copyright © 2020 AlexandrMazurov. All rights reserved.
//

import Foundation

extension Date {

    func timeWithDefaultFormat() -> String {
        return dateString(with: "HH:mm")
    }

    func dateWithDefaultFormat() -> String {
        return dateString(with: "dd.MM.yyyy")
    }

    func dateWithLocale() -> String {
        return dateString(with: "dd MMMM")
    }

    func daysOfMonth() -> String {
        return dateString(with: "dd")
    }

    private func dateString(with format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}
