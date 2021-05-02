//
//  CoreDataHelper2.swift
//  MenuBarTranslator
//
//  Created by Aiur on 01.05.2021.
//

import Foundation
import CoreData

class CoreDataHelper2 {
    typealias ObjectType = NSManagedObject
    typealias PredicateType = NSPredicate
    
    static let shared = CoreDataHelper2()
    
    var mainContext: NSManagedObjectContext { persistentContainer.viewContext }
    var backgroundContext: NSManagedObjectContext { persistentContainer.newBackgroundContext() }
    
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "MenuBarTranslator")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
//    func saveContext() {
//        mainContext.perform {
//            if self.mainContext.hasChanges {
//                do {
//                    try self.mainContext.save()
//                } catch {
//                    let nserror = error as NSError
//                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//                }
//            }
//        }
//    }
    
    func saveContext(closure: @escaping (Result<Void, Error>) -> ()) {
        mainContext.perform {
            if self.mainContext.hasChanges {
                do {
                    try self.mainContext.save()
                    closure(.success(()))
                    // debug
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                        print("context has change = \(self.mainContext.hasChanges)")
                    }
                } catch {
                    let nserror = error as NSError
                    closure(.failure(CoreDataError.saveContext))
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
    }
}

extension CoreDataHelper2: CoreDataHelper2Protocol {
    func create<T: ObjectType>(_ object: T, closure: @escaping (Result<T, Error>) -> ()) {
        saveContext { result in
            switch result {
            case .success:
                closure(.success(object))
            case .failure:
                closure(.failure(CoreDataError.create))
            }
        }
    }
    
    
    func update<T: ObjectType>(_ object: T, closure: @escaping (Result<T, Error>) -> ()) {
        create(object, closure: closure)
    }
    
    func delete<T: ObjectType>(_ object: T, closure: @escaping (Result<T, Error>) -> ()) {
        mainContext.perform { [self] in
            mainContext.delete(object)
            saveContext { result in
                switch result {
                case .success:
                    closure(.success(object))
                case .failure(let error):
                    closure(.failure(error))
                }
            }
        }
    }
    
    func fetch<T: NSManagedObject>(_ objectType: T.Type, predicate: PredicateType? = nil, limit: Int? = nil, closure: @escaping (Result<[T], Error>) -> ()) {
        let request = objectType.fetchRequest()
        request.predicate = predicate
        if let limit = limit {
            request.fetchLimit = limit
        }
        mainContext.perform {
            do {
                let result = try self.mainContext.fetch(request)
                closure(.success(result as? [T] ?? []))
            } catch {
                closure(.failure(error))
            }
        }
    }
    
    func fetchFirst<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate?, closure: @escaping (Result<T?, Error>) -> ())  {
        let request = objectType.fetchRequest()
        request.predicate = predicate
        request.fetchLimit = 1
        
        mainContext.perform {
            do {
                let result = try self.mainContext.fetch(request)
                closure(.success(result.first as? T))
            } catch {
                closure(.failure(error))
            }
        }
    }
}
