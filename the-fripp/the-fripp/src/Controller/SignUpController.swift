//
//  SignUpController.swift
//  the-fripp
//
//  Created by Никита Лисунов on 21.04.2023.
//

import UIKit

class SignUpController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        SceneDelegate.signUpView.configureUI()
        self.view.addSubview(SceneDelegate.signUpView)
        SceneDelegate.signUpView.pin(to: self.view, [.top: 0, .left: 0, .bottom: 0, .right: 0])
        self.hideKeyboardWhenTappedAround()
    }
}
