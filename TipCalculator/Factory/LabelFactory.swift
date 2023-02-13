//
//  LabelFactory.swift
//  TipCalculator
//
//  Created by Afir Thes on 13.02.2023.
//

import UIKit


struct LabelFactory {
    static func build(
        text: String?,
        font: UIFont,
        backgroundColor: UIColor = .clear,
        textColor: UIColor = ThemeColor.text,
        textAlignment: NSTextAlignment = .center) -> UILabel {
        
            let label = UILabel()
            label.text = text
            label.font = font
            label.backgroundColor = backgroundColor
            label.textAlignment = textAlignment
            label.textColor = textColor
            return label
    }
}
