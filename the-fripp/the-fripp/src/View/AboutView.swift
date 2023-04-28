//
//  AboutView.swift
//  the-fripp
//
//  Created by Никита Лисунов on 21.04.2023.
//

import UIKit

class AboutView: UIView {
    
    private let linkButton = LinkButton()
    private let aboutLabel = UILabel()
    let topRect = UIView()
    
    public func configureUI() {
        self.backgroundColor = UIColor(hex: "CCEDFF")
        setupTopRect()
        setupAboutLabel()
        setupLinkLabel()
    }
    
    private func setupTopRect() {
        self.addSubview(topRect)
        topRect.pin(to: self, [.left: 0, .right: 0])
        topRect.pinTop(to: self.topAnchor)
        topRect.setHeight(to: 110)
        topRect.layer.backgroundColor = UIColor(hex: "CCEDFF").cgColor
    }
    
    private func setupAboutLabel() {
        topRect.addSubview(aboutLabel)
        aboutLabel.pinTop(to: self.topAnchor, 62)
        aboutLabel.pin(to: self, [.left: 16, .right: 201])
        aboutLabel.text = "About"
        aboutLabel.textColor = .black
        aboutLabel.font = .systemFont(
            ofSize: 34,
            weight: .bold
        )
    }
    
    private func setupLinkLabel() {
        self.addSubview(linkButton)
        linkButton.pinCenter(to: self)
        linkButton.setupText(
            "github.com",
            UIColor(hex: "007AFF"),
            .systemFont(ofSize: 20, weight: .semibold)
        )
    }
}
