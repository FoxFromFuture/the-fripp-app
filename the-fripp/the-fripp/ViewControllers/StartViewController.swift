//
//  ViewController.swift
//  the-fripp
//
//  Created by Никита Лисунов on 08.12.2022.
//

import UIKit

class StartViewController: UIViewController {
    
    private let mainLabel = UILabel()
    private let extraLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        configureUI()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            SceneDelegate.startViewController.navigationController?.pushViewController(SceneDelegate.loginViewController, animated: true)
        }
    }

    private func configureUI() {
        view.backgroundColor = UIColor(hex: "CCEDFF")
        setupMainLabel()
        setupExtraText()
    }
    
    private func setupMainLabel() {
        view.addSubview(mainLabel)
        mainLabel.pinTop(
            to: self.view.topAnchor,
            270
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
    
    private func setupExtraText() {
        view.addSubview(extraLabel)
        extraLabel.pinBottom(
            to: self.view.bottomAnchor,
            54
        )
        extraLabel.pinCenter(
            to: self.view.centerXAnchor
        )
        extraLabel.text = "The only one"
        extraLabel.textColor = .black
        extraLabel.font = .systemFont(
            ofSize: 20,
            weight: .regular
        )
    }    
}
