//
//  Double+Extension.swift
//  TipCalculator
//
//  Created by Afir Thes on 14.02.2023.
//

import Foundation

extension Double {
    var currencyFormatted: String {
        var isWholeNumber: Bool {
            isZero ? true: !isNormal ? false : self == rounded()
        }
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = isWholeNumber ? 0 : 2
        formatter.currencyDecimalSeparator = "."
        return formatter.string(for: self) ?? ""
    }
}
