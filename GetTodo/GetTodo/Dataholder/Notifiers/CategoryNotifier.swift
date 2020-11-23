//
//  CategoryNotifier.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 21.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import Foundation
import RealmSwift

/// Protocol for views/objects to register category changes
protocol CategoryObserver: AnyObject {
    func onDidChange(categories: [CategoryItem])
}

extension CategoryObserver {
    func startObservingCategories() {
        CategoryNotifier.shared.add(self)
    }
    
    func stopObservingCategories() {
        CategoryNotifier.shared.remove(self)
    }
}

/// Stores weak references to observers which would like to get notified about changes in category list.
class CategoryNotifier {
    
    /// Container to store weak references to observers
    struct WeakContainer {
        weak var value: CategoryObserver?
    }
    
    static let shared = CategoryNotifier()
    
    init() {
        configure()
    }
    
    /// Adds observer to notifier
    ///
    /// - Parameter observer: observer instance which would like to get notifications
    func add(_ observer: CategoryObserver) {
        compact()
        observers.append(WeakContainer(value: observer))
    }
    
    /// Removes observer from notifier
    ///
    /// - Parameter observer: observer instance
    func remove(_ observer: CategoryObserver) {
        if let index = observers.firstIndex(where: { $0.value === observer }) {
            observers.remove(at: index)
        }
        compact()
    }
    
    /// Notifies observers that specified categories did change their state
    ///
    /// - Parameter categories: list of categories which changed their state
    func notifyOnDidChange(_ categories: [CategoryItem]) {
        observers.forEach({ $0.value?.onDidChange(categories: categories)})
    }
    
    private var observers = [WeakContainer]()
    private var token: NotificationToken?
}

private extension CategoryNotifier {
    /// Configures listening for changes in CategoriesProvider
    func configure() {
        token?.invalidate()
        token = CategoryProvider.token { [weak self] in
            guard let this = self else { return }
            this.notifyOnDidChange(CategoryProvider.categories())
        }
    }
    
    /// Removes containers whose observers has been deallocated
    func compact() {
        observers = observers.filter({ $0.value != nil })
    }
}
