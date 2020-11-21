//
//  CategoriesCollectionViewCell.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 21.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import UIKit


class CategoriesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryTotalTaskLabel: UILabel!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    
    
    func configure(item:CategoryItem){
        categoryImageView.image = UIImage(systemName: item.imageString)
        categoryImageView.tintColor = UIColor(hexString: item.hexColorString)
        categoryTitleLabel.text = item.name
    }
}
