//
//  CategoryItem.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 21.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import Foundation

struct CategoryItem {
    
    var identifier = ""
    
    var name = ""
    
    var password = ""
    
    var nameSurname = ""
    
}


extension CategoryItem {
    init(with model: CategoryModel) {
        identifier = model.categoryID
        name = model.name
     }
}
