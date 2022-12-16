//
//  SignUpViewController.swift
//  the-fripp
//
//  Created by Никита Лисунов on 09.12.2022.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private let mainLabel = UILabel()
    private let signUpLabel = UILabel()
    private let registerButton = RegisterButton()
    private let loginButton = LoginButton()
    public let emailTextField = UITextField()
    public let passwordTextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        view.backgroundColor = UIColor(hex: "CCEDFF")
        setupMainLabel()
        setupSignUpLabel()
        setupRegisterButton()
        setupLoginButton()
        setupEmailTextField()
        setupPasswordTextField()
    }
    
    private func setupMainLabel() {
        view.addSubview(mainLabel)
        mainLabel.pinTop(
            to: self.view.topAnchor,
            147
        )
        mainLabel.pinCenter(
            to: self.view.centerXAnchor
        )
        mainLabel.text = "The Fripp"
        mainLabel.textColor = .black
        mainLabel.font = .systemFont(
            ofSize: 32,
            weight: .regular
        )
    }
    
    private func setupSignUpLabel() {
        view.addSubview(signUpLabel)
        signUpLabel.pinTop(
            to: self.view.topAnchor,
            372
        )
        signUpLabel.pinCenter(
            to: self.view.centerXAnchor
        )
        signUpLabel.text = "SignUp"
        signUpLabel.textColor = .black
        signUpLabel.font = .systemFont(
            ofSize: 24,
            weight: .regular
        )
    }
    
    private func setupRegisterButton() {
        view.addSubview(registerButton)
        registerButton.pinBottom(
            to: self.view.bottomAnchor,
            84
        )
        registerButton.pinCenter(
            to: self.view.centerXAnchor
        )
        registerButton.setupText(
            "Register",
            UIColor(hex: "007AFF"),
            .systemFont(ofSize: 24, weight: .regular)
        )
    }
    
    private func setupLoginButton() {
        view.addSubview(loginButton)
        loginButton.pinBottom(
            to: self.view.bottomAnchor,
            267
        )
        loginButton.pin(
            to: self.view,
            [.left: 266, .right: 43]
        )
        loginButton.setupText(
            "Login",
            UIColor(hex: "007AFF"),
            .systemFont(ofSize: 14, weight: .regular)
        )
    }
    
    private func setupEmailTextField() {
        view.addSubview(emailTextField)
        emailTextField.placeholder = "E-mail"
        emailTextField.font = .systemFont(
            ofSize: 14,
            weight: .regular
        )
        emailTextField.pinTop(to: self.view.topAnchor, 440)
        emailTextField.pin(to: self.view, [.left: 50, .right: 50])
        emailTextField.backgroundColor = UIColor(hex: "CCEDFF")
        let paddingView = UIView(frame: CGRect(x: emailTextField.frame.size.width + 10, y: 0, width: emailTextField.frame.size.width, height: emailTextField.frame.size.height))
        emailTextField.leftView = paddingView
        emailTextField.leftViewMode = .always
        emailTextField.layer.shadowColor = UIColor.white.cgColor
        emailTextField.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        emailTextField.layer.shadowOpacity = 1.0
        emailTextField.layer.shadowRadius = 0.0
//        emailTextField.setHeight(to: 100.0)
//        self.emailTextField.addBottomBorder(color: .white, width: 1.0)
    }
    
    private func setupPasswordTextField() {
        view.addSubview(passwordTextField)
        passwordTextField.placeholder = "Password"
        passwordTextField.font = .systemFont(
            ofSize: 14,
            weight: .regular
        )
        passwordTextField.pinTop(to: emailTextField.bottomAnchor, 53)
        passwordTextField.pin(to: self.view, [.left: 50, .right: 50])
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
