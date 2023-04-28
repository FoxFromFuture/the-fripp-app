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
        if let curUserEmail = SceneDelegate.signUpView.emailTextField.text, let curUserPassword = SceneDelegate.signUpView.passwordTextField.text {
            if curUserEmail != "" && curUserPassword != "" {
                let user = User(email: curUserEmail, password: curUserPassword)
                User.signUpUser(user: user)
                if curStatus {
                    SceneDelegate.signUpController.navigationController?.pushViewController(
                        SceneDelegate.welcomeController, animated: true
                    )
                }
            }
        }
    }
}
