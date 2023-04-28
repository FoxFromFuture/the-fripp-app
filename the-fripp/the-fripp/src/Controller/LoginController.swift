//
//  LoginController.swift
//  the-fripp
//
//  Created by Никита Лисунов on 21.04.2023.
//

import UIKit

class LoginController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SceneDelegate.loginView.configureUI()
        self.view.addSubview(SceneDelegate.loginView)
        SceneDelegate.loginView.pin(to: self.view, [.top: 0, .left: 0, .bottom: 0, .right: 0])
        self.hideKeyboardWhenTappedAround()
    }
}
