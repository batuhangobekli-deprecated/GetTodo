//
//  GetTodoSingleton.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 22.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import Foundation

///For handling clone use-case of tokenization
///Stores temporarly current user id when login & register
class TempDataHolder {
    
    public static let shared = TempDataHolder()
    
    //Stores current user id temporarly
    //Alloacated after user kills the applicatiın
    var currentUserId:String = ""
}
