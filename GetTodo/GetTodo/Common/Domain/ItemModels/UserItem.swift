//
//  UserItem.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 21.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import Foundation

struct UserItem {
    
    var identifier = ""
    
    var email = ""
    
    var password = ""
    
    var nameSurname = ""
    
}


extension UserItem {
    init(with model: UserModel) {
        identifier = model.identifier
        email = model.email
        password = model.password
        nameSurname = model.nameSurname
     }
}
