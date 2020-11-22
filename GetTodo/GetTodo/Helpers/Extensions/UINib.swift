//
//  UINib.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 21.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Instantiating view from UINib
extension UINib {

    static func instantiate<T: StoryboardIdentifiable>(nibName: String = T.storyboardIdentifier, owner: Any? = nil, options: [AnyHashable: Any]? = nil, bundle: Bundle? = nil) -> T {
        guard let view = UINib(nibName: nibName, bundle: bundle).instantiate(withOwner: owner, options: options as! [UINib.OptionsKey : Any]).first as? T else {
            fatalError("There is no nib with name \(nibName)")
        }

        return view
    }
}
