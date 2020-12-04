//
//  SavedTranslatesModel.swift
//  MenuBarTranslator
//
//  Created by Aiur on 28.11.2020.
//

import Foundation

struct SavedTranslates: Identifiable {
    let id = UUID()
    let ru: String
    let en: String
}
