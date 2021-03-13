/*
*  Copyright (C) 2021 Groupe MINASTE
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License along
* with this program; if not, write to the Free Software Foundation, Inc.,
* 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
*
*/

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
