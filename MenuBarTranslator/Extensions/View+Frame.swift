//
//  View+Extension.swift
//  MenuBarTranslator
//
//  Created by Aiur on 02.04.2021.
//

import SwiftUI

extension View {
    func frame(type: FrameType) -> some View {
        switch type {
        case .full:
            return frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        case .wide:
            return frame(minWidth: 0, maxWidth: .infinity)
        case .high:
            return frame(minHeight: 0, maxHeight: .infinity)
        }
    }
}

enum FrameType {
    case full
    case wide
    case high
}
