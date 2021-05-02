//
//  CoreDataErrors.swift
//  MenuBarTranslator
//
//  Created by Aiur on 01.05.2021.
//

import Foundation

enum CoreDataError: Error {
    case create
    case saveContext
}

extension CoreDataError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .create:
            return "Creating is failed"
        case .saveContext:
            return "Saving context is failed"
        }
    }
}
