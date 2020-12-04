//
//  Language.swift
//  MenuBarTranslator
//
//  Created by Aiur on 28.11.2020.
//

import Foundation

enum Language: String, CaseIterable, Identifiable, Codable {
    case en
    case ru

    var id: String { self.rawValue }
}
