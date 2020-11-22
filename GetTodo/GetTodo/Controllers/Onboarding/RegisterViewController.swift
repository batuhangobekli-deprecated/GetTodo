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
    @IBOutlet weak var emailAdressTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleUI()
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    func styleUI(){
        fullNameTextField.borderStyle = .roundedRect
        passwordTextfield.borderStyle = .roundedRect
        emailAdressTextField.borderStyle = .roundedRect
        emailAdressTextField.backgroundColor = UIColor(hexString: "#F2F3F7")
        passwordTextfield.backgroundColor = UIColor(hexString: "#F2F3F7")
        fullNameTextField.backgroundColor = UIColor(hexString: "#F2F3F7")
    }
    
    @IBAction func registerButtonDidTap(_ sender: Any) {
        let registerResultTuple = UserProvider.register(email: self.emailAdressTextField.text ?? "", password: self.passwordTextfield.text ?? "", fullName: fullNameTextField.text ?? "")
        
        if !(registerResultTuple.isSuccess){
            let alert = UIAlertController(title: "Error", message: "Email is already in use.Please enter another email", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            Dataholder.shared.currentUserId = registerResultTuple.currentUserId
            self.navigateToHomePage()
        }
    }
}

extension RegisterViewController {
    func navigateToHomePage(){
        let story = UIStoryboard(name: "Home", bundle:nil)
        let homeViewController = story.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.setViewControllers([homeViewController], animated: true)
    }
}
