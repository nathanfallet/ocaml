//
//  UIColorExtension.swift
//  OCaml
//
//  Created by Nathan FALLET on 01/03/2021.
//

import UIKit

extension UIColor {
    
    // Convert UIColor to integer
    func toInt() -> Int {
        // Get colors as floats
        var rf: CGFloat = 0
        var gf: CGFloat = 0
        var bf: CGFloat = 0
        var af: CGFloat = 0
        getRed(&rf, green: &gf, blue: &bf, alpha: &af)
        
        // Convert to integers
        let r = Int(rf * 255)
        let g = Int(gf * 255)
        let b = Int(bf * 255)
        return r << 16 | g << 8 | b
    }
    
}
