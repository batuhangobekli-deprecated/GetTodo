//
//  CommonUtility.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 22.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import Foundation
import UIKit

class CommonUtility {
    public static let shared = CommonUtility()
    
    func prepareBasicAlert(message:String,title:String,buttonTitle:String,viewController:UIViewController){
        let alert = UIAlertController(title:title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func navigateToHomePage(navigationController:UINavigationController?){
        guard let navController = navigationController else{ return }
        let story = UIStoryboard(name: "Home", bundle:nil)
        let homeViewController = story.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        navController.setNavigationBarHidden(false, animated: true)
        navController.setViewControllers([homeViewController], animated: true)
    }
}
