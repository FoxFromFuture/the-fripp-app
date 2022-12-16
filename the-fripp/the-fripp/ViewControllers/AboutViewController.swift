//
//  AboutViewController.swift
//  the-fripp
//
//  Created by Никита Лисунов on 09.12.2022.
//

import UIKit

class AboutViewController: UIViewController {
    private let linkButton = LinkButton()
    private let aboutLabel = UILabel()
    private let topRect = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        topRect.addBottomBorder(color: .white, thickness: 1.0)
    }

    private func configureUI() {
        view.backgroundColor = UIColor(hex: "CCEDFF")
        setupTopRect()
        setupAboutLabel()
        setupLinkLabel()
    }
    
    private func setupTopRect() {
        view.addSubview(topRect)
        topRect.pin(to: self.view, [.left: 0, .right: 0])
        topRect.pinTop(to: self.view.topAnchor)
        topRect.setHeight(to: 110)
        topRect.layer.backgroundColor = UIColor(hex: "CCEDFF").cgColor
    }
    
    private func setupAboutLabel() {
        topRect.addSubview(aboutLabel)
        aboutLabel.pinTop(to: self.view.topAnchor, 62)
        aboutLabel.pin(to: self.view, [.left: 16, .right: 201])
        aboutLabel.text = "About"
        aboutLabel.textColor = .black
        aboutLabel.font = .systemFont(
            ofSize: 34,
            weight: .bold
        )
    }
    
    private func setupLinkLabel() {
        view.addSubview(linkButton)
        linkButton.pinCenter(to: self.view)
        linkButton.setupText(
            "github.com",
            UIColor(hex: "007AFF"),
            .systemFont(ofSize: 20, weight: .semibold)
        )
    }
}
