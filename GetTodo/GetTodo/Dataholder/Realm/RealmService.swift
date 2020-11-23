//
//  RealmService.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 21.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import RealmSwift

class RealmService {

    //Db version
    static let version: UInt64 = 1

    ///Configures default realm configurations.
    static func configure() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: version, migrationBlock: migrate)
    }

    /// Writes safe to realm
    ///
    /// - Parameter writeClosure: closure to write/update object
    static func write(_ writeClosure: ()->()) throws {
        let realm = try Realm()
        try realm.safeWrite(writeClosure)
    }

    /// Creates object  to realm
    ///
    /// - Parameter object: object to create
    static func add(_ object: Object) throws {
        let realm = try Realm()
        try realm.safeWrite {
            realm.add(object)
        }
    }

    /// Deletes object from realm
    ///
    /// - Parameter object: object to delete
    static func remove(_ object: Object) throws {
        let realm = try Realm()
        try realm.safeWrite {
            realm.delete(object)
        }
    }

    /// Deletes all objects with type from realm
    ///
    /// - Parameter type: type of objects to delete in realm
    static func removeAll(of type: Object.Type) throws {
        let realm = try Realm()
        try realm.safeWrite {
            realm.delete(realm.objects(type))
        }
    }
    
    /// Default migration function
    static func migrate(migration: Migration, oldVersion: UInt64) {}
}

extension Realm {
    func safeWrite( _ writeClosure: () -> ()) throws {
        if isInWriteTransaction {
            writeClosure()
        } else {
            try write { writeClosure() }
        }
    }
}
