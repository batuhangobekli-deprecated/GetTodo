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

//MARK: - PROVIDER FUNCTIONS
extension LoginViewController {
    
    /// Check for valid email adress && check for pasword
    /// Then call Providers Login function
    func login(){
        let emailAdress = emailAdressTextField.text ?? ""
        let password = passwordTextfield.text ?? ""
        
        //Check for email is valid
        if CommonUtility.shared.isValidEmail(emailAdress){
            
            //Check for password is empty
            if !password.isEmpty {
                
                //Assign login result to loginResultTuple  
                let loginResultTuple = UserProvider.login(email: emailAdress,password: password)
                
                //Check for login is success
                if !loginResultTuple.isSuccess{
                    CommonUtility.shared.prepareBasicAlert(message:"Please check your email and password" , title: "Error", buttonTitle: "OK", viewController: self)
                    
                }else{
                    
                    //For temp data holding act as tokenization system used TempDataHolder
                    //Assign currentUserId to temp currentUserId
                    TempDataHolder.shared.currentUserId = loginResultTuple.currentUserId
                    
                    //Then navigate to home page
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
