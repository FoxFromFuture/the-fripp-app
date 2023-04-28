//
//  StartController.swift
//  the-fripp
//
//  Created by Никита Лисунов on 21.04.2023.
//

import UIKit

class StartController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        SceneDelegate.startView.configureUI()
        self.view.addSubview(SceneDelegate.startView)
        SceneDelegate.startView.pin(to: self.view, [.top: 0, .left: 0, .bottom: 0, .right: 0])
        self.navigationController?.isNavigationBarHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            SceneDelegate.startController.navigationController?.pushViewController(SceneDelegate.loginController, animated: true)
        }
    }
}
