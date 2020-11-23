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
    
    /// Present One button UIAlertController
    ///
    /// - Parameter message: message of alert
    /// - Parameter title: title of alert
    /// - Parameter buttonTitle: title of button
    /// - Parameter viewController: Viewcontroller to presented by
    func prepareBasicAlert(message:String,title:String,buttonTitle:String,viewController:UIViewController){
        let alert = UIAlertController(title:title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    /// Navigate's and set root viewcontroller as home vc
    ///
    /// - Parameter navigationController: Optional navigation controller
    func navigateToHomePage(navigationController:UINavigationController?){
        //Check for navigationController is null
        guard let navController = navigationController else{ return }
        
        let story = UIStoryboard(name: "Home", bundle:nil)
        let homeViewController = story.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        navController.setNavigationBarHidden(false, animated: true)
        navController.setViewControllers([homeViewController], animated: true)
    }

    /// Check for given email is valid
    ///
    /// - Parameter email: given email string
    /// - Returns: Bool indicates given email is valid
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
