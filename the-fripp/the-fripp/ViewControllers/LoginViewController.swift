//
//  LoginViewController.swift
//  the-fripp
//
//  Created by Никита Лисунов on 08.12.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let mainLabel = UILabel()
    private let loginLabel = UILabel()
    private let enterButton = EnterButton()
    private let registrationButton = RegistrationButton()
    public let emailTextField = UITextField()
    public let passwordTextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        configureUI()
    }

    private func configureUI() {
        view.backgroundColor = UIColor(hex: "CCEDFF")
        setupMainLabel()
        setupLoginLabel()
        setupEnterButton()
        setupRegistrationButton()
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
    
    private func setupLoginLabel() {
        view.addSubview(loginLabel)
        loginLabel.pinTop(
            to: self.view.topAnchor,
            372
        )
        loginLabel.pinCenter(
            to: self.view.centerXAnchor
        )
        loginLabel.text = "Login"
        loginLabel.textColor = .black
        loginLabel.font = .systemFont(
            ofSize: 24,
            weight: .regular
        )
    }
    
    private func setupEnterButton() {
        view.addSubview(enterButton)
        enterButton.pinBottom(
            to: self.view.bottomAnchor,
            84
        )
        enterButton.pinCenter(
            to: self.view.centerXAnchor
        )
        enterButton.setupText(
            "Enter",
            UIColor(hex: "007AFF"),
            .systemFont(ofSize: 24, weight: .regular)
        )
    }
    
    private func setupRegistrationButton() {
        view.addSubview(registrationButton)
        registrationButton.pinBottom(
            to: self.view.bottomAnchor,
            267
        )
        registrationButton.pin(
            to: self.view,
            [.left: 266, .right: 43]
        )
        registrationButton.setupText(
            "Registration",
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
