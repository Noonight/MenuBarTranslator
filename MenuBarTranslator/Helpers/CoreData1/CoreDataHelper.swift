//
//  CoreDataHelper.swift
//  MenuBarTranslator
//
//  Created by Aiur on 25.04.2021.
//

import Foundation
import CoreData

class CoreDataHelper {
    typealias ObjectType = NSManagedObject
    typealias PredicateType = NSPredicate
    
    static let shared = CoreDataHelper()
    
    var context: NSManagedObjectContext { persistentContainer.viewContext }
//    var context: NSManagedObjectContext { persistentContainer.newBackgroundContext() }
    
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "MenuBarTranslator")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

// MARK: - DBHelperProtocol

extension CoreDataHelper: DBHelperProtocol {
    func create(_ object: NSManagedObject) {
        do {
            try context.save()
        } catch {
            fatalError("error saving context while creating an object")
        }
    }
    
    func fetch<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate? = nil, sort: [NSSortDescriptor]? = nil, limit: Int? = nil) -> Result<[T], Error> {
        let request = objectType.fetchRequest()
        request.predicate = predicate
        if let limit = limit {
            request.fetchLimit = limit
        }
        if let sort = sort {
            request.sortDescriptors = sort
        }
        do {
            let result = try context.fetch(request)
            return .success(result as? [T] ?? [])
        } catch {
            return .failure(error)
        }
    }
    
    func fetchFirst<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate?) -> Result<T?, Error> {
        let result = fetch(objectType, predicate: predicate, limit: 1)
        switch result {
        case .success(let todos):
            return .success(todos.first as? T)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func update(_ object: NSManagedObject) {
        do {
            try context.save()
        } catch {
            fatalError("error saving context while updating an object")
        }
    }
    
    func delete(_ object: NSManagedObject) {
        context.delete(object)
        do {
            try context.save()
        } catch {
            fatalError("error saving context while deleting an object")
        }
    }
}
