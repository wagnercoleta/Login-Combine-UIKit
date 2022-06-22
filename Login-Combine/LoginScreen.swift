//
//  LoginScreen.swift
//  Login-Combine
//
//  Created by Wagner Coleta on 22/06/22.
//

import UIKit

protocol LoginScreenProtocol: AnyObject {
    func clickLoginButton()
}

class LoginScreen: UIView {

    weak var delegate: LoginScreenProtocol?
    
    lazy var viewContainer:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var loginLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Login"
        label.font = UIFont.systemFont(ofSize: 70, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    lazy var emailTextFeild: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        tf.borderStyle = .roundedRect
        tf.keyboardType = .emailAddress
        tf.placeholder = "Digite seu e-mail:"
        tf.textColor = .darkGray
        return tf
    }()
    
    lazy var passwordlTextFeild: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        tf.borderStyle = .roundedRect
        tf.keyboardType = .default
        tf.placeholder = "Digite sua senha:"
        tf.textColor = .darkGray
        return tf
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Logar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 7.5
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(self.tappedLoginButton), for: .touchUpInside)
        return button
    }()
    
    @objc private func tappedLoginButton() {
        self.delegate?.clickLoginButton()
    }
    
    private func addElemented() {
        self.addSubview(self.viewContainer)
        self.viewContainer.addSubview(self.loginLabel)
        self.viewContainer.addSubview(self.emailTextFeild)
        self.viewContainer.addSubview(self.passwordlTextFeild)
        self.viewContainer.addSubview(self.loginButton)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            
            self.viewContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.viewContainer.widthAnchor.constraint(equalTo: self.widthAnchor),
            self.viewContainer.heightAnchor.constraint(equalToConstant: 320),
            
            self.loginLabel.centerXAnchor.constraint(equalTo: self.viewContainer.centerXAnchor),
            self.loginLabel.topAnchor.constraint(equalTo: self.viewContainer.topAnchor),
            
            self.emailTextFeild.topAnchor.constraint(equalTo: self.loginLabel.bottomAnchor, constant: 25),
            self.emailTextFeild.leadingAnchor.constraint(equalTo: self.viewContainer.leadingAnchor, constant: 20),
            self.emailTextFeild.trailingAnchor.constraint(equalTo: self.viewContainer.trailingAnchor, constant: -20),
            self.emailTextFeild.heightAnchor.constraint(equalToConstant: 45),
            
            self.passwordlTextFeild.topAnchor.constraint(equalTo: self.emailTextFeild.bottomAnchor, constant: 15),
            self.passwordlTextFeild.leadingAnchor.constraint(equalTo: self.emailTextFeild.leadingAnchor),
            self.passwordlTextFeild.trailingAnchor.constraint(equalTo: self.emailTextFeild.trailingAnchor),
            self.passwordlTextFeild.heightAnchor.constraint(equalTo: self.emailTextFeild.heightAnchor),
            
            self.loginButton.topAnchor.constraint(equalTo: self.passwordlTextFeild.bottomAnchor, constant: 20),
            self.loginButton.leadingAnchor.constraint(equalTo: self.emailTextFeild.leadingAnchor),
            self.loginButton.trailingAnchor.constraint(equalTo: self.emailTextFeild.trailingAnchor),
            self.loginButton.heightAnchor.constraint(equalTo: self.emailTextFeild.heightAnchor)
            
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addElemented()
        self.setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
