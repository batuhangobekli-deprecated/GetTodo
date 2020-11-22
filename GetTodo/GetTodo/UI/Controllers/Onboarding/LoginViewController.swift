//
//  LoginViewController.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 22.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailAdressTextField: RoundTextField!
    @IBOutlet weak var passwordTextfield: RoundTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func loginButtonDidTap(_ sender: Any) {
        let loginResultTuple = UserProvider.login(email: emailAdressTextField.text ?? "",password: passwordTextfield.text ?? "")
        
        if !loginResultTuple.isSuccess{
            CommonUtility.shared.prepareBasicAlert(message:"Please check your email and password" , title: "Error", buttonTitle: "OK", viewController: self)
        }else{
            TempDataHolder.shared.currentUserId = loginResultTuple.currentUserId
            CommonUtility.shared.navigateToHomePage(navigationController: self.navigationController)
        }
    }
}

