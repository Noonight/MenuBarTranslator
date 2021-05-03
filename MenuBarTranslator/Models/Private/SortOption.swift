//
//  SortOption.swift
//  MenuBarTranslator
//
//  Created by Aiur on 04.05.2021.
//

import Foundation
import CoreData

enum SortOption: String, Codable, CaseIterable, Equatable {
    case relevance
    case newer
    case older
    case lessRepeat
    case moreRepeat
    
    func sortDescription() -> [NSSortDescriptor] {
        var sortDescription: [NSSortDescriptor] = [NSSortDescriptor]()
        switch self {
        case .relevance:
            sortDescription.append(NSSortDescriptor(key: "lastRepeatDate", ascending: false))
            sortDescription.append(NSSortDescriptor(key: "repeatCounter", ascending: true))
        case .newer:
            sortDescription.append(NSSortDescriptor(key: "lastRepeatDate", ascending: false))
        case .older:
            sortDescription.append(NSSortDescriptor(key: "lastRepeatDate", ascending: true))
        case .lessRepeat:
            sortDescription.append(NSSortDescriptor(key: "repeatCounter", ascending: true))
        case .moreRepeat:
            sortDescription.append(NSSortDescriptor(key: "repeatCounter", ascending: false))
        }
        return sortDescription
    }
}
