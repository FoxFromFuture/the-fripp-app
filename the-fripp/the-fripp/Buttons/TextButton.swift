//
//  EnterButton.swift
//  the-fripp
//
//  Created by Никита Лисунов on 08.12.2022.
//

import UIKit

class TextButton: UIView {
    init() {
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupText(
        _ text: String,
        _ color: UIColor,
        _ font: UIFont
    ) {
        let label = UILabel()
        label.text = text
        addSubview(label)
        label.pin(to: self)
        label.textColor = color
        label.textAlignment = .center
        label.font = font
    }
}
