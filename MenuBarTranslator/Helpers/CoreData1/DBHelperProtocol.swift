//
//  DBHelperProtocol.swift
//  MenuBarTranslator
//
//  Created by Aiur on 25.04.2021.
//

import Foundation

public protocol DBHelperProtocol {
    associatedtype ObjectType
    associatedtype PredicateType
    
    func create(_ object: ObjectType)
    func fetchFirst(_ objectType: ObjectType.Type, predicate: PredicateType?) -> Result<ObjectType?, Error>
    func fetch(_ objectType: ObjectType.Type, predicate: PredicateType?, sort: [NSSortDescriptor]?, limit: Int?) -> Result<[ObjectType], Error>
    func update(_ object: ObjectType)
    func delete(_ object: ObjectType)
}
