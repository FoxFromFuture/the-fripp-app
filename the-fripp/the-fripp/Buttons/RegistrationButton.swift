//
//  RegistrationButton.swift
//  the-fripp
//
//  Created by Никита Лисунов on 13.12.2022.
//

import UIKit

final class RegistrationButton: TextButton {
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
            action: #selector(self.registrationButtonPressed(_:))
        )
        addGestureRecognizer(tapRecognizer)
    }
    
    @objc
    private func registrationButtonPressed(
        _ sender: UITapGestureRecognizer? = nil
    ) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        SceneDelegate.loginViewController.navigationController?.pushViewController(
            SceneDelegate.signUpViewController, animated: true
        )
    }
}
