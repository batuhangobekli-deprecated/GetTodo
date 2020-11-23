//
//  RegisterViewController.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 22.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import UIKit

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var emailAdressTextField: RoundTextField!
    @IBOutlet weak var passwordTextfield: RoundTextField!
    @IBOutlet weak var fullNameTextField: RoundTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func registerButtonDidTap(_ sender: Any) {
        self.register()
    }
}

//MARK: - PROVIDER FUNCTIONS
extension RegisterViewController{
    /// Check for valid email adress && check for pasword &&  check for fullname
    /// Then call Providers Register function
    func register(){
        let emailAdress = emailAdressTextField.text ?? ""
        let password = passwordTextfield.text ?? ""
        let fullName = fullNameTextField.text ?? ""
        
        //Check for email is valid
        if CommonUtility.shared.isValidEmail(emailAdress){
            
            //Check for password is empty and full name is empty
            if !password.isEmpty && !fullName.isEmpty {
                
                //Assign register result to registerResultTuple
                let registerResultTuple = UserProvider.register(email: self.emailAdressTextField.text ?? "", password: self.passwordTextfield.text ?? "", fullName: fullNameTextField.text ?? "")
                
                //Check for register is success
                if !(registerResultTuple.isSuccess){
                    CommonUtility.shared.prepareBasicAlert(message:"Email is already in use.Please enter another email",title:"Error",buttonTitle:"OK", viewController: self)
                    
                }else{
                    
                    //For temp data holding act as tokenization system used TempDataHolder
                    //Assign currentUserId to temp currentUserId
                    TempDataHolder.shared.currentUserId = registerResultTuple.currentUserId
                    
                    //Then navigate to home page
                    CommonUtility.shared.navigateToHomePage(navigationController: self.navigationController)
                }
            }else{
                CommonUtility.shared.prepareBasicAlert(message:"Please fill all the fields",title:"Error",buttonTitle:"OK", viewController: self)
            }
        }else{
            CommonUtility.shared.prepareBasicAlert(message:"Please enter a valid email" , title: "Error", buttonTitle: "OK", viewController: self)
        }
    }
}
