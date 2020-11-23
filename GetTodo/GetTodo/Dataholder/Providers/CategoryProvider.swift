//
//  CategoryProvider.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 21.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import Foundation
import RealmSwift

/// Category Provider ( Table Data Gateway and Row Data Gateway) manages Category Domain objects
class CategoryProvider {
    
    private static let adapter = RealmAdapter<CategoryModel>()
    
    static let shared = CategoryProvider()
    
    /// Returns all categories
    ///
    /// - Returns: Array of categories recorded to realm
    static func categories() -> [CategoryItem] {
        return adapter.objects()?.map({$0.toItem}) ?? []
    }
    
    /// Returns category by its primary key
    ///
    /// - Parameter identifier: primary key of category
    /// - Returns: Optional CategoryItem  instance
    static func category(for identifier: String) -> CategoryItem? {
        return categoryModel(for: identifier)?.toItem
    }
    
    /// Returns task count of selected category
    ///
    /// - Parameter categoryId: primary key of category
    /// - Returns: count of tasks by selected category
    static func getCategoryTaskCount(categoryId:String) -> Int {
        return TaskProvider.tasks(categoryId: categoryId).count
    }
    
    /// Creates category in realm by given categoryItem
    ///
    /// - Parameter categoryItem: category item object to create
    static func create(with categoryItem: CategoryItem) {
        if categoryModel(for: categoryItem.identifier) != nil{
            return
        }
        guard (try? adapter.create(["identifier": categoryItem.identifier,"name":categoryItem.name,"imageString":categoryItem.imageString,"hexColorString":categoryItem.hexColorString])) != nil else {
            fatalError("RealmObjectAdapter failed to create Object. Please check Realm configuration.")
        }
    }
    
    /// Updates category model in database with category item
    ///
    /// - Parameter category: category item object to update
    static func update(category: CategoryItem) {
        guard let model = categoryModel(for: category.identifier) else { return }
        try? RealmService.write {
            model.name = category.name
            model.imageString = category.imageString
            model.hexColorString = category.hexColorString
        }
    }
    
    /// Deletes category model in database with category item
    ///
    /// - Parameter user: category  item object to delete
    static func remove(category: CategoryItem) {
        guard let model = categoryModel(for: category.identifier) else { return }
        try? RealmService.remove(model)
    }
}

extension CategoryProvider {
    
    /// Creates notification token for changes in user list
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
    
    /// Creates notification token for changes in specified category
    ///
    /// - Parameter category: completion closure called on change
    /// - Parameter onDidChange: completion closure called on change
    /// - Returns: returns notification token which has to be stored as strong reference
    static func token(for category: CategoryItem, _ onDidChange: @escaping ()->() ) -> NotificationToken? {
        if let model = categoryModel(for: category.identifier) {
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

extension CategoryProvider {
    /// Check and instantiate category model for given identifier(pk)
    ///
    /// - Parameter identifier: category pk to search
    /// - Returns: Optional category model if exist
    static func categoryModel(for identifier: String) -> CategoryModel? {
        return adapter.object(primaryKey: identifier)
    }
}

extension CategoryProvider {
    
    /// Creates category models in realm if not exist
    func createUserDummyCategories() {
        var travelCategory = CategoryItem()
        travelCategory.identifier = "1"
        travelCategory.imageString = "airplane"
        travelCategory.name = "Travel"
        travelCategory.hexColorString = "#f6e58d"
        CategoryProvider.create(with: travelCategory)

        var workCategory = CategoryItem()
        workCategory.identifier = "2"
        workCategory.imageString = "briefcase.fill"
        workCategory.name = "Work"
        workCategory.hexColorString = "#3f4996"
        CategoryProvider.create(with: workCategory)

        var musicCategory = CategoryItem()
        musicCategory.identifier = "3"
        musicCategory.imageString = "music.note.list"
        musicCategory.name = "Music"
        musicCategory.hexColorString = "#ff7979"
        CategoryProvider.create(with: musicCategory)

        var homeCategory = CategoryItem()
        homeCategory.identifier = "4"
        homeCategory.imageString = "house.fill"
        homeCategory.name = "Home"
        homeCategory.hexColorString = "#badc58"
        CategoryProvider.create(with: homeCategory)

        var studyCategory = CategoryItem()
        studyCategory.identifier = "5"
        studyCategory.imageString = "pencil"
        studyCategory.name = "Study"
        studyCategory.hexColorString = "#dff9fb"
        CategoryProvider.create(with: studyCategory)

        var shopCategory = CategoryItem()
        shopCategory.identifier = "6"
        shopCategory.imageString = "cart.fill.badge.plus"
        shopCategory.name = "Shoppping"
        shopCategory.hexColorString = "#7ed6df"
        CategoryProvider.create(with: shopCategory)
        
        var artCategory = CategoryItem()
        artCategory.identifier = "7"
        artCategory.imageString = "paintbrush.fill"
        artCategory.name = "Art"
        artCategory.hexColorString = "#e056fd"
        CategoryProvider.create(with: artCategory)
    }
}




