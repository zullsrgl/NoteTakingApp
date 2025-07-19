//
//  Extansion.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 14.07.2025.
//
import UIKit

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: CGFloat.random(in: 0.3...1),
            green: CGFloat.random(in: 0.3...1),
            blue: CGFloat.random(in: 0.3...1),
            alpha: 1.0
        )
    }
}
