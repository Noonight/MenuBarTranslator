//
//  Array+SavedWord.swift
//  MenuBarTranslator
//
//  Created by Aiur on 28.04.2021.
//

import Foundation

extension Array where Element == SavedWord {
    mutating func updateElement(it: Element, to: Element) {
        if let positionIt = firstIndex(of: it) {
            self.remove(at: positionIt)
            self.insert(to, at: positionIt)
        }
    }
}
