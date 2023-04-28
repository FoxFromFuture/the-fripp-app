//
//  UIView+bottomBorder.swift
//  the-fripp
//
//  Created by Никита Лисунов on 14.12.2022.
//

import UIKit

extension UIView {
    func addBottomBorder(color: UIColor, thickness: CGFloat) {
        let bottomBorder = CALayer()
        bottomBorder.backgroundColor = color.cgColor
        bottomBorder.frame = CGRect(x: 0, y: self.frame.size.height - thickness, width: self.frame.size.width, height: thickness)
        self.layer.addSublayer(bottomBorder)
    }
    
    func addTopBorder(color: UIColor, thickness: CGFloat) {
        let topBorder = CALayer()
        topBorder.backgroundColor = color.cgColor
        topBorder.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: thickness)
        self.layer.addSublayer(topBorder)
    }
    
    func addLeftBorder(color: UIColor, thickness: CGFloat) {
        let leftBorder = CALayer()
        leftBorder.backgroundColor = color.cgColor
        leftBorder.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.size.height)
        self.layer.addSublayer(leftBorder)
    }
    
    func addRightBorder(color: UIColor, thickness: CGFloat) {
        let rightBorder = CALayer()
        rightBorder.backgroundColor = color.cgColor
        rightBorder.frame = CGRect(x: self.frame.size.width - thickness, y: 0, width: thickness, height: self.frame.size.height)
        self.layer.addSublayer(rightBorder)
    }
}
