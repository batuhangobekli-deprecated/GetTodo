//
//  TaskItem.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 21.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import Foundation

struct TaskItem {
    
    var identifier: String = ""
    
    var taskDescription: String = ""
    
    var date: Date
    
    var categoryId = ""
    
    var userId = ""
}

extension TaskItem {
    init(with model: TaskModel) {
        identifier = model.identifier
        taskDescription = model.taskDescription
        date = model.date
        categoryId = model.categoryId
        userId = model.userId
     }
}
