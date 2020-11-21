//
//  TaskModel.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 21.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import Foundation
import RealmSwift

class TaskModel: Object {
    @objc dynamic var identifier = UUID().uuidString
    @objc dynamic var taskDescription:String = ""
    @objc dynamic var date = Date(timeIntervalSince1970: 1)
    @objc dynamic var categoryId = ""
    @objc dynamic var userId = ""

    override static func primaryKey() -> String? {
      return "identifier"
    }
}

extension TaskModel {
    var toItem: TaskItem {
        return TaskItem(with: self)
    }
}
