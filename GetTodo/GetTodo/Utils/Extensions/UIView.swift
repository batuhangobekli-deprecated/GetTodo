//
//  UIView.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 21.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import UIKit

extension UIView {
    func roundTop(radius:CGFloat = 5){
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
    }
    
  
    func makeCircular(){
        self.layer.cornerRadius = self.frame.size.width/2
        self.layer.masksToBounds = true
    }
}
