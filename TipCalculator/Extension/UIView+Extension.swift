//
//  UIView+Extension.swift
//  TipCalculator
//
//  Created by Afir Thes on 13.02.2023.
//

import UIKit


extension UIView {
    
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.cornerRadius = radius
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor = backgroundCGColor
    }
    
    func addCornerRaius(radius: CGFloat) {
        layer.masksToBounds = false
        layer.cornerRadius = radius
    }
    
    func addRoundecCornerds(corners: CACornerMask, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = [corners]
    }
}
