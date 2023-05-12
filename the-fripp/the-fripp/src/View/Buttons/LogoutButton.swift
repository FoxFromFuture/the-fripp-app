//
//  LogoutButton.swift
//  the-fripp
//
//  Created by Никита Лисунов on 12.05.2023.
//

import UIKit

final class LogoutButton: TextButton {
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
            action: #selector(self.logoutButtonPressed(_:))
        )
        addGestureRecognizer(tapRecognizer)
    }
    
    @objc
    private func logoutButtonPressed(
        _ sender: UITapGestureRecognizer? = nil
    ) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        SceneDelegate.mainController.navigationController?.popToViewController(
            SceneDelegate.loginController, animated: true
        )
    }
}
