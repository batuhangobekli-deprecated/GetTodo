//
//  UITableView.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 21.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {

    func dequeueReusableCell<T: UITableViewCell>(at indexPath: IndexPath, withIdentifier identifier: String = T.storyboardIdentifier) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            fatalError("There is no cell with \(identifier) identifier")
        }

        return cell
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withIdentifier identifier: String = T.storyboardIdentifier) -> T {
        guard let header = self.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? T else {
            fatalError("There is no header/footer with \(identifier) identifier")
        }

        return header
    }
}

// MARK: - Registering

extension UITableView {

    func register<T: UITableViewCell>(class aClass: T.Type, identifier: String = T.storyboardIdentifier) {
        register(aClass, forCellReuseIdentifier: identifier)
    }

    func register<T: UITableViewCell>(nib: T.Type, nibName: String = T.storyboardIdentifier, identifier: String = T.storyboardIdentifier) {
        let nib = UINib(nibName: nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: identifier)
    }

    func register<T: UITableViewHeaderFooterView>(class aClass: T.Type, identifier: String = T.storyboardIdentifier) {
        register(aClass, forHeaderFooterViewReuseIdentifier: identifier)
    }

    func register<T: UITableViewHeaderFooterView>(nib: T.Type, nibName: String = T.storyboardIdentifier, identifier: String = T.storyboardIdentifier) {
        let nib = UINib(nibName: nibName, bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }
}
