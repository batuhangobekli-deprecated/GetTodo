//
//  UserModel.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 21.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import Foundation
import RealmSwift

class UserModel: Object {
    @objc dynamic var identifier = UUID().uuidString
    @objc dynamic var email:String = ""
    @objc dynamic var password = ""
    @objc dynamic var nameSurname = ""

    override static func primaryKey() -> String? {
      return "identifier"
    }
}

extension UserModel {
    var toItem: UserItem {
        return UserItem(with: self)
    }
}
