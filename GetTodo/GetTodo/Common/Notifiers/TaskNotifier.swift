//
//  TaskNotifier.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 22.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import Foundation
import RealmSwift

protocol TaskObserver: AnyObject {
    func onDidChange(tasks: [TaskItem])
}

extension TaskObserver {
    func startObservingCategories() {
        TaskNotifier.shared.add(self)
    }
    
    func stopObservingCategories() {
        TaskNotifier.shared.remove(self)
    }
}


class TaskNotifier {
    
    struct WeakContainer {
        weak var value: TaskObserver?
    }
    
    static let shared = TaskNotifier()
    
    init() {
        configure()
    }
    
    func add(_ observer: TaskObserver) {
        compact()
        observers.append(WeakContainer(value: observer))
    }
    
    func remove(_ observer: TaskObserver) {
        if let index = observers.firstIndex(where: { $0.value === observer }) {
            observers.remove(at: index)
        }
        compact()
    }
    
    func notifyOnDidChange(_ tasks: [TaskItem]) {
        observers.forEach({ $0.value?.onDidChange(tasks: tasks)})
    }
    
    private var observers = [WeakContainer]()
    private var token: NotificationToken?
}

private extension TaskNotifier {
    func configure() {
        token?.invalidate()
        token = TaskProvider.token { [weak self] in
            guard let this = self else { return }
            this.notifyOnDidChange(TaskProvider.tasks())
        }
    }
    
    func compact() {
        observers = observers.filter({ $0.value != nil })
    }
}
