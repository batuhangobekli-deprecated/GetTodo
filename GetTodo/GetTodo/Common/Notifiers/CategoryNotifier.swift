//
//  CategoryNotifier.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 21.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import Foundation
import RealmSwift

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


class CategoryNotifier {
    
    struct WeakContainer {
        weak var value: CategoryObserver?
    }
    
    static let shared = CategoryNotifier()
    
    init() {
        configure()
    }
    
    func add(_ observer: CategoryObserver) {
        compact()
        observers.append(WeakContainer(value: observer))
    }
    
    func remove(_ observer: CategoryObserver) {
        if let index = observers.firstIndex(where: { $0.value === observer }) {
            observers.remove(at: index)
        }
        compact()
    }
    
    func notifyOnDidChange(_ categories: [CategoryItem]) {
        observers.forEach({ $0.value?.onDidChange(categories: categories)})
    }
    
    private var observers = [WeakContainer]()
    private var token: NotificationToken?
}

private extension CategoryNotifier {
    func configure() {
        token?.invalidate()
        token = CategoryProvider.token { [weak self] in
            guard let this = self else { return }
            this.notifyOnDidChange(CategoryProvider.categories())
        }
    }
    
    func compact() {
        observers = observers.filter({ $0.value != nil })
    }
}
