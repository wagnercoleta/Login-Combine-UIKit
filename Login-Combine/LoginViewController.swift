//
//  LoginViewController.swift
//  Login-Combine
//
//  Created by Wagner Coleta on 22/06/22.
//

import UIKit
import Combine

class LoginViewController: UIViewController {

    private var screen: LoginScreen?
    private var loginValidCombine = LoginValidCombine()

    private func setup() {
        self.screen?.delegate = self
        self.screen?.setDelegateTextField(delegate: self)
        
        if let emailTextField = self.screen?.emailTextFeild {
            self.loginValidCombine.setupEmailTextField(emailTextField)
        }
        
        if let passwordTextField = self.screen?.passwordlTextFeild {
            self.loginValidCombine.setupPasswordTextField(passwordTextField)
        }
                
        if let btnLogin = self.screen?.loginButton {
            self.loginValidCombine.setupLoginButton(btnLogin)
        }
    }
    
    override func loadView() {
        self.screen = LoginScreen()
        self.view = self.screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension LoginViewController: LoginScreenProtocol {
    func clickLoginButton() {
        print("Botão acionado!!!")
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let textFieldText = textField.text ?? ""
        let text = (textFieldText as NSString).replacingCharacters(in: range, with: string)
        
        if textField == self.screen?.emailTextFeild {
            self.loginValidCombine.email = text
        }
        
        if textField == self.screen?.passwordlTextFeild {
            self.loginValidCombine.password = text
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
