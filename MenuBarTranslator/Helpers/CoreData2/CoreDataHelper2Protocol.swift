//
//  CoreDataHelper2Protocol.swift
//  MenuBarTranslator
//
//  Created by Aiur on 01.05.2021.
//

import Foundation

public protocol CoreDataHelper2Protocol {
    associatedtype ObjectType
    associatedtype PredicateType
    
    func create(_ object: ObjectType, closure: @escaping (Result<ObjectType, Error>) -> ())
    func fetchFirst(_ objectType: ObjectType.Type, predicate: PredicateType?, closure: @escaping (Result<ObjectType?, Error>) -> ())
    func fetch(_ objectType: ObjectType.Type, predicate: PredicateType?, limit: Int?, closure: @escaping (Result<[ObjectType], Error>) -> ())
    func update(_ object: ObjectType, closure: @escaping (Result<ObjectType, Error>) -> ())
    func delete(_ object: ObjectType, closure: @escaping (Result<ObjectType, Error>) -> ())
}

public extension CoreDataHelper2Protocol {
    func fetch(_ objectType: ObjectType.Type, predicate: PredicateType? = nil, limit: Int? = nil, closure: @escaping (Result<[ObjectType], Error>) -> ()) {
        return fetch(objectType, predicate: predicate, limit: limit, closure: closure)
    }
}
