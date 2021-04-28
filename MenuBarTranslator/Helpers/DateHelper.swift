//
//  DateHelper.swift
//  MenuBarTranslator
//
//  Created by Aiur on 28.04.2021.
//

import Foundation

final class DateHelper {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    static func format(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
