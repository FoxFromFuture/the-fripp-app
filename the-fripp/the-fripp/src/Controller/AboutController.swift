//
//  AboutController.swift
//  the-fripp
//
//  Created by Никита Лисунов on 21.04.2023.
//

import UIKit

class AboutController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SceneDelegate.aboutView.configureUI()
        self.view.addSubview(SceneDelegate.aboutView)
        SceneDelegate.aboutView.pin(to: self.view, [.top: 0, .left: 0, .bottom: 0, .right: 0])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        SceneDelegate.aboutView.topRect.addBottomBorder(color: .white, thickness: 1.0)
    }
}
