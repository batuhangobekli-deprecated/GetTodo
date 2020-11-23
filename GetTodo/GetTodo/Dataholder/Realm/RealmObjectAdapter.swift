//
//  RealmObjectAdapter.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 21.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import Foundation
import RealmSwift

class RealmAdapter<T: Object> {
    
    /// Returns realm objects list with given type
    ///
    /// - Returns: Type of Generic Result list
    func objects() -> Results<T>? {
        return try? Realm().objects(T.self)
    }
    
    /// Returns realm objects list with given type
    ///
    /// - Parameter type: type of objects to get
    /// - Returns: Type of Generic Results
    func objects(_ type:T.Type) -> Results<T>? {
        return try? Realm().objects(type)
    }
    
    /// Returns object with given primary key
    ///
    /// - Parameter primaryKey: pk for identify / search for object
    /// - Returns: object and return T model type
    func object(primaryKey:String) -> T? {
        return try? Realm().object(ofType: T.self, forPrimaryKey: primaryKey)
    }
    
    /// Creates object  with given key value pairs
    ///
    /// - Parameter value: dictionary of values
    /// - Returns: Creates object and return T model type
    @discardableResult func create(_ value: [String: Any]? = nil) throws -> T {
        let object = T()
        
        if let value = value {
            object.setValuesForKeys(value)
        }
        
        let realm = try Realm()
        try realm.write {
            realm.add(object)
        }
        
        return object
    }
    
    /// Add object to realm
    /// - Parameter object: given realm object
    func add(_ object: T) throws {
        let realm = try Realm()
        try realm.write {
            realm.add(object)
        }
    }
    
    func edit(_ object: T, set value: [String: Any]) throws {
        let realm = try Realm()
        try realm.write {
            object.setValuesForKeys(value)
        }
    }
    
    func remove(_ object: T) throws {
        let realm = try Realm()
        try realm.write {
            realm.delete(object)
        }
    }
}
