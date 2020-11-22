//
//  ASA.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 21.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {

    func instantiateViewController<T: UIViewController>(withIdentifier identifier: String = T.storyboardIdentifier) -> T {
        guard let controller = self.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("There is no view controller with \(identifier) identifier")
        }

        return controller
    }

    func instantiateViewController<T: RawRepresentable>(withIdentifier identifier: T) -> UIViewController where T.RawValue == String {
        return instantiateViewController(withIdentifier: identifier.rawValue)
    }
}
