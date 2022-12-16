//
//  LoginButton.swift
//  the-fripp
//
//  Created by Никита Лисунов on 13.12.2022.
//

import UIKit

final class LoginButton: TextButton {
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
            action: #selector(self.loginButtonPressed(_:))
        )
        addGestureRecognizer(tapRecognizer)
    }
    
    @objc
    private func loginButtonPressed(
        _ sender: UITapGestureRecognizer? = nil
    ) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        SceneDelegate.signUpViewController.navigationController?.popToViewController(
            SceneDelegate.loginViewController, animated: true
        )
    }
}
