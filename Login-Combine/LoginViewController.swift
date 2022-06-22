//
//  LoginViewController.swift
//  Login-Combine
//
//  Created by Wagner Coleta on 22/06/22.
//

import UIKit

class LoginViewController: UIViewController {

    private var screen: LoginScreen?
    
    override func loadView() {
        self.screen = LoginScreen()
        self.view = self.screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.screen?.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension LoginViewController: LoginScreenProtocol {
    func clickLoginButton() {
        
    }
}
