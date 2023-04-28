//
//  WelcomeView.swift
//  the-fripp
//
//  Created by Никита Лисунов on 21.04.2023.
//

import UIKit

class WelcomeView: UIView {
    
    private let mainLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let startButton = StartButton()
    
    public func configureUI() {
        self.backgroundColor = UIColor(hex: "CCEDFF")
        setupMainLabel()
        setupDescriptionLabel()
        setupStartButton()
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
        mainLabel.text = "Welcome!"
        mainLabel.textColor = .black
        mainLabel.font = .systemFont(
            ofSize: 32,
            weight: .regular
        )
    }
    
    private func setupDescriptionLabel() {
        self.addSubview(descriptionLabel)
        descriptionLabel.pinTop(
            to: self.topAnchor,
            343
        )
        descriptionLabel.pinCenter(
            to: self.centerXAnchor
        )
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.text = "You’ve just registerd in\nThe Fripp!\nThank you for choosing us and\nhave a nice use!"
        descriptionLabel.textColor = .black
        descriptionLabel.font = .systemFont(
            ofSize: 20,
            weight: .regular
        )
    }
    
    private func setupStartButton() {
        self.addSubview(startButton)
        startButton.pinBottom(
            to: self.bottomAnchor,
            84
        )
        startButton.pinCenter(
            to: self.centerXAnchor
        )
        startButton.setupText(
            "Get Started",
            UIColor(hex: "007AFF"),
            .systemFont(ofSize: 24, weight: .regular)
        )
    }
}
