//
//  InputViewButton.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 22.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import UIKit

class InputViewButton: UIButton {

    var myView = UIView()
    var toolBarView = UIView()

    override var inputView: UIView {
        get {
            return self.myView
        }

        set {
            self.myView = newValue
            self.becomeFirstResponder()
        }
    }

    override var inputAccessoryView: UIView {
        get {
            return self.toolBarView
        }
        set {
            self.toolBarView = newValue
        }
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

}
