//
//  UserNotifier.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 22.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import Foundation
import RealmSwift

/// Protocol for views/objects to register user changes
protocol UserObserver: AnyObject {
    func onDidChange(users: [UserItem])
}

extension UserObserver {
    func startObservingUsers() {
        UserNotifier.shared.add(self)
    }
    
    func stopObservingUsers() {
        UserNotifier.shared.remove(self)
    }
}

/// Stores weak references to observers which would like to get notified about changes in user list.
class UserNotifier {
    
    /// Container to store weak references to observers
    struct WeakContainer {
        weak var value: UserObserver?
    }
    
    static let shared = UserNotifier()
    
    init() {
        configure()
    }
    
    /// Adds observer to notifier
    ///
    /// - Parameter observer: observer instance which would like to get notifications
    func add(_ observer: UserObserver) {
        compact()
        observers.append(WeakContainer(value: observer))
    }
    
    /// Removes observer from notifier
    ///
    /// - Parameter observer: observer instance
    func remove(_ observer: UserObserver) {
        if let index = observers.firstIndex(where: { $0.value === observer }) {
            observers.remove(at: index)
        }
        compact()
    }
    
    /// Notifies observers that specified users did change their state
    ///
    /// - Parameter users: list of users which changed their state
    func notifyOnDidChange(_ users: [UserItem]) {
        observers.forEach({ $0.value?.onDidChange(users: users)})
    }
    
    private var observers = [WeakContainer]()
    private var token: NotificationToken?
}

private extension UserNotifier {
    /// Configures listening for changes in UserProvider
    func configure() {
        token?.invalidate()
        token = UserProvider.token { [weak self] in
            guard let this = self else { return }
            this.notifyOnDidChange(UserProvider.users()) //TODO
        }
    }
    
    /// Removes containers whose observers has been deallocated
    func compact() {
        observers = observers.filter({ $0.value != nil })
    }
}
