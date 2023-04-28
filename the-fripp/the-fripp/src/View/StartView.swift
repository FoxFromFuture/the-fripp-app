//
//  StartView.swift
//  the-fripp
//
//  Created by Никита Лисунов on 21.04.2023.
//

import UIKit

class StartView: UIView {
    
    private let mainLabel = UILabel()
    private let extraLabel = UILabel()
    
    public func configureUI() {
        self.backgroundColor = UIColor(hex: "CCEDFF")
        setupMainLabel()
        setupExtraText()
    }
    
    private func setupMainLabel() {
        self.addSubview(mainLabel)
        mainLabel.pinTop(
            to: self.topAnchor,
            270
        )
        mainLabel.pinCenter(
            to: self.centerXAnchor
        )
        mainLabel.text = "The Fripp"
        mainLabel.textColor = .black
        mainLabel.font = .systemFont(
            ofSize: 32,
            weight: .regular
        )
    }
    
    private func setupExtraText() {
        self.addSubview(extraLabel)
        extraLabel.pinBottom(
            to: self.bottomAnchor,
            54
        )
        extraLabel.pinCenter(
            to: self.centerXAnchor
        )
        extraLabel.text = "The only one"
        extraLabel.textColor = .black
        extraLabel.font = .systemFont(
            ofSize: 20,
            weight: .regular
        )
    }
}
