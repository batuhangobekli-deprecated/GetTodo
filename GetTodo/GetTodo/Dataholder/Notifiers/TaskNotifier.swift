//
//  TaskNotifier.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 22.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import Foundation
import RealmSwift

/// Protocol for views/objects to register task changes
protocol TaskObserver: AnyObject {
    func onDidChange(tasks: [TaskItem])
}

extension TaskObserver {
    func startObservingTasks() {
        TaskNotifier.shared.add(self)
    }
    
    func stopObservingTasks() {
        TaskNotifier.shared.remove(self)
    }
}

/// Stores weak references to observers which would like to get notified about changes in task list.
class TaskNotifier {
    
    /// Container to store weak references to observers
    struct WeakContainer {
        weak var value: TaskObserver?
    }
    
    static let shared = TaskNotifier()
    
    init() {
        configure()
    }
    
    /// Adds observer to notifier
    ///
    /// - Parameter observer: observer instance which would like to get notifications
    func add(_ observer: TaskObserver) {
        compact()
        observers.append(WeakContainer(value: observer))
    }
    
    /// Removes observer from notifier
    ///
    /// - Parameter observer: observer instance
    func remove(_ observer: TaskObserver) {
        if let index = observers.firstIndex(where: { $0.value === observer }) {
            observers.remove(at: index)
        }
        compact()
    }
    
    /// Notifies observers that specified tasks did change their state
    ///
    /// - Parameter tasks: list of tasks which changed their state
    func notifyOnDidChange(_ tasks: [TaskItem]) {
        observers.forEach({ $0.value?.onDidChange(tasks: tasks)})
    }
    
    private var observers = [WeakContainer]()
    private var token: NotificationToken?
}

private extension TaskNotifier {
    /// Configures listening for changes in TaskProvider
    func configure() {
        token?.invalidate()
        token = TaskProvider.token { [weak self] in
            guard let this = self else { return }
            this.notifyOnDidChange(TaskProvider.tasks())
        }
    }
    
    /// Removes containers whose observers has been deallocated
    func compact() {
        observers = observers.filter({ $0.value != nil })
    }
}
