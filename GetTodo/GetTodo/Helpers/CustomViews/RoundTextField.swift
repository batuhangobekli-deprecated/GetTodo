//
//  RoundTextField.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 23.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import UIKit

@IBDesignable
class RoundTextField: UITextField {
    
    var padding: UIEdgeInsets {
        get {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: paddingValue)
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    @IBInspectable var paddingValue: CGFloat = 0
    
    
    var cornerRadius: CGFloat = 20 {
        didSet {
            layer.cornerRadius = self.cornerRadius
            layer.masksToBounds = self.cornerRadius > 0
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = self.cornerRadius
    }
    
}
