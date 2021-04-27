//
//  SavedWord+CoreDataProperties.swift
//  MenuBarTranslator
//
//  Created by Aiur on 26.04.2021.
//
//

import Foundation
import CoreData


extension SavedWord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedWord> {
        return NSFetchRequest<SavedWord>(entityName: "SavedWord")
    }

    @NSManaged public var en: String
    @NSManaged public var id: UUID?
    @NSManaged public var lastRepeatDate: Date?
    @NSManaged public var repeatCounter: Int64
    @NSManaged public var ru: String

}

extension SavedWord : Identifiable {

}
