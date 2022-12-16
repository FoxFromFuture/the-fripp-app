//
//  EnterButton.swift
//  the-fripp
//
//  Created by Никита Лисунов on 13.12.2022.
//

import UIKit

final class EnterButton: TextButton {
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
            action: #selector(self.enterButtonPressed(_:))
        )
        addGestureRecognizer(tapRecognizer)
    }
    
    @objc
    private func enterButtonPressed(
        _ sender: UITapGestureRecognizer? = nil
    ) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        if let curUserEmail = SceneDelegate.loginViewController.emailTextField.text, let curUserPassword = SceneDelegate.loginViewController.passwordTextField.text {
            if curUserEmail != "" && curUserPassword != "" {
                let allUsers = DataManager.shared.users()
                for user in allUsers {
                    if user.email == curUserEmail && user.password == curUserPassword {
                        SceneDelegate.mainViewController.currentUser = user
                        SceneDelegate.loginViewController.navigationController?.pushViewController(
                            SceneDelegate.mainViewController, animated: true
                        )
                        break
                    }
                }
            }
        }
    }
}
