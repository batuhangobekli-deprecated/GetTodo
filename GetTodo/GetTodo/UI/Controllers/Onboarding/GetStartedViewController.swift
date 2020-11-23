//
//  GetStartedViewController.swift
//  GetTodo
//
//  Created by Batuhan Göbekli on 22.11.2020.
//  Copyright © 2020 Batuhan Göbekli. All rights reserved.
//

import UIKit

class GetStartedViewController: UIViewController {

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //To achive navigationbar to hidden 
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func gettingStartedButtonDidTap(_ sender: Any) {
        self.navigateToRegister()
    }
    
    @IBAction func loginButtonDidTap(_ sender: Any) {
        self.navigateToLogin()
    }
}

//MARK: - HELPER FUNCTIONS
extension GetStartedViewController{
    
    ///Navigates to Login View Controller
    func navigateToLogin(){
        let storyBoard = UIStoryboard(name: "Onboarding", bundle: nil)
        let loginViewController:LoginViewController = storyBoard.instantiateViewController()
        self.navigationController?.pushViewController(loginViewController, animated: true)
    }
    ///Navigates to Register View Controller
    func navigateToRegister(){
        let storyBoard = UIStoryboard(name: "Onboarding", bundle: nil)
        let registerViewController:RegisterViewController = storyBoard.instantiateViewController()
        self.navigationController?.pushViewController(registerViewController, animated: true)
    }
}
