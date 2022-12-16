//
//  WelcomeViewController.swift
//  the-fripp
//
//  Created by Никита Лисунов on 08.12.2022.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    private let mainLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let startButton = StartButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        view.backgroundColor = UIColor(hex: "CCEDFF")
        setupMainLabel()
        setupDescriptionLabel()
        setupStartButton()
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
        mainLabel.text = "Welcome!"
        mainLabel.textColor = .black
        mainLabel.font = .systemFont(
            ofSize: 32,
            weight: .regular
        )
    }
    
    private func setupDescriptionLabel() {
        view.addSubview(descriptionLabel)
        descriptionLabel.pinTop(
            to: self.view.topAnchor,
            343
        )
        descriptionLabel.pinCenter(
            to: self.view.centerXAnchor
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
        view.addSubview(startButton)
        startButton.pinBottom(
            to: self.view.bottomAnchor,
            84
        )
        startButton.pinCenter(
            to: self.view.centerXAnchor
        )
        startButton.setupText(
            "Get Started",
            UIColor(hex: "007AFF"),
            .systemFont(ofSize: 24, weight: .regular)
        )
    }
}
