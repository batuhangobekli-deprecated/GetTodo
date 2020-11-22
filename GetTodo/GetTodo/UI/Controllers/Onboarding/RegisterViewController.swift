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
        let registerResultTuple = UserProvider.register(email: self.emailAdressTextField.text ?? "", password: self.passwordTextfield.text ?? "", fullName: fullNameTextField.text ?? "")
        
        if !(registerResultTuple.isSuccess){
            CommonUtility.shared.prepareBasicAlert(message:"Email is already in use.Please enter another email",title:"Error",buttonTitle:"OK", viewController: self)
        }else{
            TempDataHolder.shared.currentUserId = registerResultTuple.currentUserId
            CommonUtility.shared.navigateToHomePage(navigationController: self.navigationController)
        }
    }
}
