//
//  UserProvider.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 22.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import Foundation
import RealmSwift

/// User Provider ( Table Data Gateway and Row Data Gateway) manages Category Domain objects
class UserProvider {
    private static let adapter = RealmAdapter<UserModel>()
    
    static let shared = UserProvider()
    
    /// Returns all users
    ///
    /// - Returns: Array of users recorded to realm
    static func users() -> [UserItem] {
        return adapter.objects()?.map({$0.toItem}) ?? []
    }
    
    /// Returns user by its primary key
    ///
    /// - Parameter identifier: primary key of user
    /// - Returns: UserItem  instance
    static func user(for identifier: String) -> UserItem? {
        return userModel(for: identifier)?.toItem
    }
    
    /// Creates user in database
    ///
    /// - Parameter email: email to create
    /// - Parameter password: password to create
    /// - Parameter fullName: fullname of fullName
    /// - Returns: user item object
    @discardableResult static func create(email:String,password:String,fullName:String) -> UserItem {
        guard let model = try? adapter.create(["email":email,"password":password,"nameSurname":fullName]) else {
            fatalError("RealmObjectAdapter failed to create Object. Please check Realm configuration.")
        }
        return model.toItem
    }
    
    /// Updates user model in database with user item
    ///
    /// - Parameter user: user item object to update
    static func update(user: UserItem) {
        guard let model = userModel(for: user.identifier) else { return }
        try? RealmService.write {
            model.nameSurname = user.nameSurname
            model.email = user.email
            model.password = user.password
        }
    }
    
    /// Deletes user model in database with user item
    ///
    /// - Parameter user: user item object to delete
    static func remove(user: UserItem) {
        guard let model = userModel(for: user.identifier) else { return }
        try? RealmService.remove(model)
    }
}

//MARK: - AUTHENTICATION
extension UserProvider{
    /// Login user with given parameters
      ///
      /// - Parameter email: email of user
      /// - Parameter password: password of user
      /// - Returns: Tuple contains loginResult and  user primarykey
      static func login(email:String,password:String) -> (isSuccess:Bool,currentUserId:String){
          let userModel = adapter.objects(UserModel.self)?
              .filter("email == %@", email)
              .filter("password == %@", password).first
          
          if let user = userModel{
              return (true,user.identifier)
          }
          return(false,"")
      }
      
      /// Register user with given parameters
      ///
      /// - Parameter email: email to register
      /// - Parameter password: password to register
      /// - Parameter fullName: fullname of user
      /// - Returns: Tuple contains loginResult and  created user primarykey
      static func register(email:String,password:String,fullName:String) -> (isSuccess:Bool,currentUserId:String){
          let sameEmailUser = adapter.objects(UserModel.self)?
              .filter("email == %@", email).first
          
          if sameEmailUser == nil{
              let createdUser = create(email: email, password: password, fullName: fullName)
              return (true,createdUser.identifier)
          }
          return (false,"")
      }
}

//MARK: - TOKEN/NOTIFICATON
extension UserProvider {
    /// Creates notification token for changes in user list
    ///
    /// - Parameter onDidChange: completion closure called on change
    /// - Returns: returns notification token which has to be stored as strong reference
    static func token(_ onDidChange: @escaping ()->() ) -> NotificationToken? {
        return adapter.objects()?.observe({ (change) in
            switch change {
            case .update:
                onDidChange()
            default: break
            }
        })
    }
    
    /// Creates notification token for changes in specified user
    ///
    /// - Parameter user: completion closure called on change
    /// - Parameter onDidChange: completion closure called on change
    /// - Returns: returns notification token which has to be stored as strong reference
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
    /// Check and instantiate user model for given identifier(pk)
    ///
    /// - Parameter identifier: user pk to search
    /// - Returns: Optional user model if exist
    static func userModel(for identifier: String) -> UserModel? {
        return adapter.object(primaryKey: identifier)
    }
}




