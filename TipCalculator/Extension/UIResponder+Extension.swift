//
//  UIResponder+Extension.swift
//  TipCalculator
//
//  Created by Afir Thes on 14.02.2023.
//

import UIKit

extension UIResponder {
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
