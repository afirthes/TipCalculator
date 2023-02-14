//
//  Data+Extension.swift
//  TipCalculator
//
//  Created by Afir Thes on 14.02.2023.
//

import Foundation

extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
    
    
}
