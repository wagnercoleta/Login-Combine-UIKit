//
//  ValidCombine.swift
//  Login-Combine
//
//  Created by Wagner Coleta on 22/06/22.
//

import UIKit
import Combine

class LoginValidCombine {
    
    // MARK: - PUBLISHED
    @Published var email = ""
    @Published var password = ""
    
    // MARK: - EMAIL
    private var validateEmail: AnyPublisher<String?, Never> {
        return $email
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap { email in
                return Future { promise in
                    self.emailAvailable(email) { available in
                        promise(.success(available ? email : nil))
                    }
                }
            }
            .eraseToAnyPublisher()
    }
    
    private func emailAvailable(_ email: String, completion: (Bool) -> Void) {
        if isValidEmail(email) {
            completion(true)
        } else {
            completion(false)
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    // MARK: - PASSWORD
    private var validatePassword: AnyPublisher<String?, Never> {
        return $password
            .removeDuplicates()
            .map { password in
                guard password != "", password.count > 3 else { return nil }
                return password
            }
            .map {
                ($0 ?? "") == "123" ? nil : $0
            }
            .eraseToAnyPublisher()
    }
    
    // MARK: - CREDENTIALS
    private var validateCredentials: AnyPublisher<(String, String)?, Never> {
        return Publishers.CombineLatest(validateEmail, validatePassword)
            .receive(on: RunLoop.main)
            .map { email, password in
                guard let emailValid = email, let passwordValid = password else { return nil }
                return (emailValid, passwordValid)
            }
            .eraseToAnyPublisher()
    }
    
    // MARK: - SUBSCRIBER
    private var anyCancellableSubscriber: Set<AnyCancellable> = []
    
    // MARK: - SETUP CONTROLS
    public func setupEmailTextField(_ emailTextField: UITextField) {
        self.validateEmail
            .map {
                if ($0 != nil) {
                    return ColorConst.primary
                } else {
                    return ColorConst.disabled
                }
            }
            .receive(on: RunLoop.main)
            .assign(to: \.textColor, on: emailTextField)
            .store(in: &anyCancellableSubscriber)
    }
    
    public func setupPasswordTextField(_ passwordTextField: UITextField) {
        self.validatePassword
            .map {
                if ($0 != nil) {
                    return ColorConst.primary
                } else {
                    return ColorConst.disabled
                }
            }
            .receive(on: RunLoop.main)
            .assign(to: \.textColor, on: passwordTextField)
            .store(in: &anyCancellableSubscriber)
    }
    
    public func setupLoginButton(_ loginButton: UIButton) {
        self.validateCredentials
            .map {
                return $0 != nil
            }
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: loginButton)
            .store(in: &anyCancellableSubscriber)
        
        self.validateCredentials
            .map {
                if $0 != nil {
                    return ColorConst.primary
                } else {
                    return ColorConst.disabled
                }
            }
            .receive(on: RunLoop.main)
            .assign(to: \.backgroundColor, on: loginButton)
            .store(in: &anyCancellableSubscriber)
    }
}
