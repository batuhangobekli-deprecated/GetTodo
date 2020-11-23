//
//  TaskProvider.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 22.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import Foundation
import RealmSwift

/// Task Provider ( Table Data Gateway and Row Data Gateway) manages Category Domain objects
class TaskProvider {
    
    private static let adapter = RealmAdapter<TaskModel>()
    
    static let shared = TaskProvider()
    
    /// Returns all tasks of user & sorted by asc
    ///
    /// - Returns: Array of task item recorded on realm
    static func tasks() -> [TaskItem] {
        return adapter.objects()?
            .filter("userId == %@", TempDataHolder.shared.currentUserId)
            .sorted(byKeyPath: "date", ascending: false)
            .map({$0.toItem}) ?? []
    }
    
    /// Returns all tasks of current user and selected category  & sorted by asc
    ///
    /// - Parameter categoryId: selected category identifier for tasks
    /// - Returns: Array of task item recorded on realm
    static func tasks(categoryId:String) -> [TaskItem] {
        return adapter.objects(TaskModel.self)?
            .filter("categoryId == %@", categoryId)
            .filter("userId == %@", TempDataHolder.shared.currentUserId)
            .sorted(byKeyPath: "date", ascending: false)
            .map({$0.toItem}) ?? []
    }
    
    /// Creates task in realm
    ///
    /// - Parameter task: task item to create
    static func create(task:TaskItem){
        guard (try? adapter.create(["taskDescription":task.taskDescription,"date":task.date,"categoryId":task.categoryId,"userId":TempDataHolder.shared.currentUserId])) != nil else
        {
                fatalError("RealmObjectAdapter failed to create Object. Please check Realm configuration.")
        }
    }
    
    /// Updates task model in database with task item
    ///
    /// - Parameter task: task item object to update
    static func update(task: TaskItem) {
        guard let model = taskModel(for: task.identifier) else { return }
        try? RealmService.write {
            model.date = task.date
            model.taskDescription = task.taskDescription
            model.userId = task.userId
            model.categoryId = task.categoryId
        }
    }
    
    /// Deletes task model in database with task item
    ///
    /// - Parameter task: task item object to delete
    static func remove(task: TaskItem) {
        guard let model = taskModel(for: task.identifier) else { return }
        try? RealmService.remove(model)
    }
}

extension TaskProvider {
    
    /// Creates notification token for changes in task list
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
    
    /// Creates notification token for changes in specified task
    ///
    /// - Parameter task: completion closure called on change
    /// - Parameter onDidChange: completion closure called on change
    /// - Returns: returns notification token which has to be stored as strong reference
    static func token(for task: TaskItem, _ onDidChange: @escaping ()->() ) -> NotificationToken? {
        if let model = taskModel(for: task.identifier) {
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

extension TaskProvider {
    /// Check and instantiate task model for given identifier(pk)
    ///
    /// - Parameter identifier: task pk to search
    /// - Returns: Optional task model if exist
    static func taskModel(for identifier: String) -> TaskModel? {
        return adapter.object(primaryKey: identifier)
    }
}


