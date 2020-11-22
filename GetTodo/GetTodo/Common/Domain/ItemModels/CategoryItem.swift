//
//  CategoryItem.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 21.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import Foundation

struct CategoryItem {
    var identifier:String = ""
    var name:String = ""
    var imageString:String = ""
    var hexColorString:String = ""
}


extension CategoryItem {
    init(with model: CategoryModel) {
        identifier = model.identifier
        name = model.name
        imageString = model.imageString
        hexColorString = model.hexColorString
     }
}
