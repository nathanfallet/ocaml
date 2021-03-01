//
//  IntExtension.swift
//  OCaml
//
//  Created by Nathan FALLET on 01/03/2021.
//

import UIKit

extension Int {
    
    // Convert integer to UIColor
    func toUIColor() -> UIColor {
        let r = (self & 0xFF0000) >> 16
        let g = (self & 0xFF00) >> 8
        let b = (self & 0xFF)
        return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: 1)
    }
    
}
