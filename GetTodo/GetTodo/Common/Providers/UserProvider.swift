//
//  UserProvider.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 22.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import Foundation
import RealmSwift

class UserProvider {
    
    private static let adapter = RealmObjectAdapter<UserModel>()
    
    static let shared = UserProvider()
    
    static func users() -> [UserItem] {
        return adapter.objects()?.map({$0.toItem}) ?? []
    }
    
    static func user(for identifier: String) -> UserItem? {
        return userModel(for: identifier)?.toItem
    }
    
    static func login(email:String,password:String) -> (isSuccess:Bool,currentUserId:String){
        let userModel = adapter.objects(UserModel.self)?
            .filter("email == %@", email)
            .filter("password == %@", password).first
        
        if let user = userModel{
            return (true,user.identifier)
        }
        return(false,"")
    }
    
    static func register(email:String,password:String,fullName:String) -> (isSuccess:Bool,currentUserId:String){
        let sameEmailUser = adapter.objects(UserModel.self)?
            .filter("email == %@", email).first
        
        if sameEmailUser == nil{
            let createdUser = create(email: email, password: password, fullName: fullName)
            return (true,createdUser.identifier)
        }
        return (false,"")
    }
    
    @discardableResult static func create(email:String,password:String,fullName:String) -> UserItem {
        guard let model = try? adapter.create(["email":email,"password":password,"nameSurname":fullName]) else {
            fatalError("RealmObjectAdapter failed to create Object. Please check Realm configuration.")
        }
        return model.toItem
    }
    
    static func update(user: UserItem) {
        guard let model = userModel(for: user.identifier) else { return }
        try? RealmService.write {
            model.nameSurname = user.nameSurname
            model.email = user.email
            model.password = user.password
        }
    }
    
    static func remove(user: UserItem) {
        guard let model = userModel(for: user.identifier) else { return }
        try? RealmService.remove(model)
    }
}

extension UserProvider {
    
    static func token(_ onDidChange: @escaping ()->() ) -> NotificationToken? {
        return adapter.objects()?.observe({ (change) in
            switch change {
            case .update:
                onDidChange()
            default: break
            }
        })
    }
    
    
    static func token(for user: UserModel, _ onDidChange: @escaping ()->() ) -> NotificationToken? {
        if let model = userModel(for: user.identifier) {
            return model.observe { (change) in
                switch change {
                case .change: onDidChange()
                case .deleted: break
                default: break
                }
            }
        }
        return nil
    }
}

extension UserProvider {
    static func userModel(for identifier: String) -> UserModel? {
        return adapter.object(primaryKey: identifier)
    }
}




