//
//  GetTodoSingleton.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 22.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import Foundation

class TempDataHolder {
    public static let shared = TempDataHolder()
    
    var currentUserId:String = ""
}
