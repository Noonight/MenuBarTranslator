//
//  DefaultApiAddresses.swift
//  MenuBarTranslator
//
//  Created by Aiur on 21.05.2021.
//

import Foundation

enum DefaultApiAddresses: String, Codable, CaseIterable, Equatable {
    
    case local = "http://0.0.0.0:4567/translate"
    case remote = "http://noonight.savayer.space/translate"
}
