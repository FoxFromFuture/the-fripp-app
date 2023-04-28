//
//  LinkButton.swift
//  the-fripp
//
//  Created by Никита Лисунов on 14.12.2022.
//

import UIKit

class LinkButton: TextButton {
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
            action: #selector(self.linkButtonPressed(_:))
        )
        addGestureRecognizer(tapRecognizer)
    }
    
    @objc
    private func linkButtonPressed(
        _ sender: UITapGestureRecognizer? = nil
    ) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        let gitUrl = URL(string: "https://github.com/FoxFromFuture/the-fripp-app")
        UIApplication.shared.open(gitUrl!)
    }
}
