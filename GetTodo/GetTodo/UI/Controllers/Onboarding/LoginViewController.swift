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
        self.login()
    }
}


extension LoginViewController {
    func login(){
        let emailAdress = emailAdressTextField.text ?? ""
        let password = passwordTextfield.text ?? ""
        
        if CommonUtility.shared.isValidEmail(emailAdress){
            if !password.isEmpty {
                let loginResultTuple = UserProvider.login(email: emailAdress,password: password)
                
                if !loginResultTuple.isSuccess{
                    CommonUtility.shared.prepareBasicAlert(message:"Please check your email and password" , title: "Error", buttonTitle: "OK", viewController: self)
                }else{
                    TempDataHolder.shared.currentUserId = loginResultTuple.currentUserId
                    CommonUtility.shared.navigateToHomePage(navigationController: self.navigationController)
                }
            }else{
                CommonUtility.shared.prepareBasicAlert(message:"Please enter password" , title: "Error", buttonTitle: "OK", viewController: self)
            }
        }else{
            CommonUtility.shared.prepareBasicAlert(message:"Please enter a valid email" , title: "Error", buttonTitle: "OK", viewController: self)
        }
    }
}
