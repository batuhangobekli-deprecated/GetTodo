//
//  LoginViewController.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 22.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailAdressTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleUI()
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func styleUI(){
        passwordTextfield.borderStyle = .roundedRect
        emailAdressTextField.borderStyle = .roundedRect
        emailAdressTextField.backgroundColor = UIColor(hexString: "#F2F3F7")
        passwordTextfield.backgroundColor = UIColor(hexString: "#F2F3F7")
    }
    
    @IBAction func loginButtonDidTap(_ sender: Any) {
        let loginResultTuple = UserProvider.login(email: emailAdressTextField.text ?? "",password: passwordTextfield.text ?? "")
        
        if !loginResultTuple.isSuccess{
            let alert = UIAlertController(title: "Error", message: "Please check your email and password", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            Dataholder.shared.currentUserId = loginResultTuple.currentUserId
            CommonUtility.shared.navigateToHomePage(navigationController: self.navigationController)
        }
    }
}

