//
//  RegisterButton.swift
//  the-fripp
//
//  Created by Никита Лисунов on 13.12.2022.
//

import UIKit

final class RegisterButton: TextButton {
    var pressAction: (() -> Void)?
    
    override init() {
        super.init()
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        let tapRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(self.registerButtonPressed(_:))
        )
        addGestureRecognizer(tapRecognizer)
    }
    
    @objc
    private func registerButtonPressed(
        _ sender: UITapGestureRecognizer? = nil
    ) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        if let curUserEmail = SceneDelegate.signUpViewController.emailTextField.text, let curUserPassword = SceneDelegate.signUpViewController.passwordTextField.text {
            if curUserEmail != "" && curUserPassword != "" {
                let allUsers = DataManager.shared.users()
                var isUserExists = 0
                for user in allUsers {
                    if user.email == curUserEmail && user.password == curUserPassword {
                        isUserExists = 1
                    }
                }
                if isUserExists == 0 {
                    SceneDelegate.mainViewController.currentUser = DataManager.shared.user(email: curUserEmail, password: curUserPassword)
                    DataManager.shared.saveContext()
                    SceneDelegate.signUpViewController.navigationController?.pushViewController(
                        SceneDelegate.welcomeViewController, animated: true
                    )
                }
            }
        }
    }
}
