//
//  SignUpView.swift
//  the-fripp
//
//  Created by Никита Лисунов on 21.04.2023.
//

import UIKit

class SignUpView: UIView {
    
    private let mainLabel = UILabel()
    private let signUpLabel = UILabel()
    private let registerButton = RegisterButton()
    private let loginButton = LoginButton()
    public let emailTextField = UITextField()
    public let passwordTextField = UITextField()
    
    public func configureUI() {
        self.backgroundColor = UIColor(hex: "CCEDFF")
        setupMainLabel()
        setupSignUpLabel()
        setupRegisterButton()
        setupLoginButton()
        setupEmailTextField()
        setupPasswordTextField()
    }
    
    private func setupMainLabel() {
        self.addSubview(mainLabel)
        mainLabel.pinTop(
            to: self.topAnchor,
            147
        )
        mainLabel.pinCenter(
            to: self.centerXAnchor
        )
        mainLabel.text = "The Fripp"
        mainLabel.textColor = .black
        mainLabel.font = .systemFont(
            ofSize: 32,
            weight: .regular
        )
    }
    
    private func setupSignUpLabel() {
        self.addSubview(signUpLabel)
        signUpLabel.pinTop(
            to: self.topAnchor,
            372
        )
        signUpLabel.pinCenter(
            to: self.centerXAnchor
        )
        signUpLabel.text = "SignUp"
        signUpLabel.textColor = .black
        signUpLabel.font = .systemFont(
            ofSize: 24,
            weight: .regular
        )
    }
    
    private func setupRegisterButton() {
        self.addSubview(registerButton)
        registerButton.pinBottom(
            to: self.bottomAnchor,
            84
        )
        registerButton.pinCenter(
            to: self.centerXAnchor
        )
        registerButton.setupText(
            "Register",
            UIColor(hex: "007AFF"),
            .systemFont(ofSize: 24, weight: .regular)
        )
    }
    
    private func setupLoginButton() {
        self.addSubview(loginButton)
        loginButton.pinBottom(
            to: self.bottomAnchor,
            267
        )
        loginButton.pin(
            to: self,
            [.left: 266, .right: 43]
        )
        loginButton.setupText(
            "Login",
            UIColor(hex: "007AFF"),
            .systemFont(ofSize: 14, weight: .regular)
        )
    }
    
    private func setupEmailTextField() {
        self.addSubview(emailTextField)
        emailTextField.placeholder = "E-mail"
        emailTextField.font = .systemFont(
            ofSize: 14,
            weight: .regular
        )
        emailTextField.pinTop(to: self.topAnchor, 440)
        emailTextField.pin(to: self, [.left: 50, .right: 50])
        emailTextField.backgroundColor = UIColor(hex: "CCEDFF")
        let paddingView = UIView(frame: CGRect(x: emailTextField.frame.size.width + 10, y: 0, width: emailTextField.frame.size.width, height: emailTextField.frame.size.height))
        emailTextField.leftView = paddingView
        emailTextField.leftViewMode = .always
        emailTextField.layer.shadowColor = UIColor.white.cgColor
        emailTextField.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        emailTextField.layer.shadowOpacity = 1.0
        emailTextField.layer.shadowRadius = 0.0
    }
    
    private func setupPasswordTextField() {
        self.addSubview(passwordTextField)
        passwordTextField.placeholder = "Password"
        passwordTextField.font = .systemFont(
            ofSize: 14,
            weight: .regular
        )
        passwordTextField.pinTop(to: emailTextField.bottomAnchor, 53)
        passwordTextField.pin(to: self, [.left: 50, .right: 50])
        passwordTextField.backgroundColor = UIColor(hex: "CCEDFF")
        let paddingView = UIView(frame: CGRect(x: passwordTextField.frame.size.width + 10, y: 0, width: passwordTextField.frame.size.width, height: passwordTextField.frame.size.height))
        passwordTextField.leftView = paddingView
        passwordTextField.leftViewMode = .always
        passwordTextField.layer.shadowColor = UIColor.white.cgColor
        passwordTextField.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        passwordTextField.layer.shadowOpacity = 1.0
        passwordTextField.layer.shadowRadius = 0.0
    }
}
