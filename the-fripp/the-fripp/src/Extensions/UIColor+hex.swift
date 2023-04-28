//
//  UIColor+hex.swift
//  the-fripp
//
//  Created by Никита Лисунов on 08.12.2022.
//

import UIKit

extension UIColor {
    convenience init(hex: String) {
        var rgb: UInt64 = 0
        var clearedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        clearedHex = clearedHex.replacingOccurrences(of: "#", with: "")
        Scanner(string: clearedHex).scanHexInt64(&rgb)
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255,
            blue: CGFloat(rgb & 0x0000FF) / 255,
            alpha: 1
        )
    }
}
