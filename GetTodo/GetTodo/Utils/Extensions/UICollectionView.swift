//
//  UICollectionView.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 21.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import Foundation
import UIKit

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String { return String(describing: self) }
}

extension StoryboardIdentifiable where Self: UIView {
    static var storyboardIdentifier: String { return String(describing: self) }
}

extension UIViewController: StoryboardIdentifiable {}
extension UITableViewCell: StoryboardIdentifiable {}
extension UICollectionReusableView: StoryboardIdentifiable {}
extension UITableViewHeaderFooterView: StoryboardIdentifiable {}



// MARK: - Dequeuing Cells

extension UICollectionView {

    func dequeueReusableCell<T: UICollectionViewCell>(at indexPath: IndexPath, withIdentifier identifier: String = T.storyboardIdentifier) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("There is no cell with \(identifier) identifier")
        }

        return cell
    }
}

extension UICollectionView {

    func register<T: UICollectionViewCell>(nib: T.Type, nibName: String = T.storyboardIdentifier, identifier: String = T.storyboardIdentifier) {
        let nib = UINib(nibName: nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: identifier)
    }

    func register<T: UICollectionViewCell>(class aClass: T.Type, identifier: String = T.storyboardIdentifier) {
        register(aClass, forCellWithReuseIdentifier: identifier)
    }
}

extension UICollectionView {

    enum ElementKind {
        case header, footer

        fileprivate var name: String {
            switch self {
            case .header: return UICollectionView.elementKindSectionHeader
            case .footer: return UICollectionView.elementKindSectionFooter
            }
        }
    }
}

extension UICollectionView {

    func register<T: UICollectionReusableView>(class aClass: T.Type, elementKind kind: ElementKind, identifier: String = T.storyboardIdentifier) {
        register(aClass, forSupplementaryViewOfKind: kind.name, withReuseIdentifier: identifier)
    }

    func register<T: UICollectionReusableView>(nib: T.Type, nibName: String = T.storyboardIdentifier, elementKind kind: ElementKind, identifier: String = T.storyboardIdentifier) {
        let nib = UINib(nibName: nibName, bundle: nil)
        register(nib, forSupplementaryViewOfKind: kind.name, withReuseIdentifier: identifier)
    }
}
