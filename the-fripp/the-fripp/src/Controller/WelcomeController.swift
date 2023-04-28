//
//  WelcomeController.swift
//  the-fripp
//
//  Created by Никита Лисунов on 21.04.2023.
//

import UIKit

class WelcomeController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SceneDelegate.welcomeView.configureUI()
        self.view.addSubview(SceneDelegate.welcomeView)
        SceneDelegate.welcomeView.pin(to: self.view, [.top: 0, .left: 0, .bottom: 0, .right: 0])
    }
}
