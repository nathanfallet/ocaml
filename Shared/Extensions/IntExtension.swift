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

import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

extension Int {
    
    // Convert integer to NativeColor
    func toNativeColor() -> NativeColor {
        let r = (self & 0xFF0000) >> 16
        let g = (self & 0xFF00) >> 8
        let b = (self & 0xFF)
        return NativeColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: 1)
    }
    
    // Convert to color or get default
    func toNativeColorOrDefault(for key: String) -> NativeColor {
        if self == -1 {
            switch key {
            case "backgroundColor":
                return .systemBackground
            case "plainColor":
                return .label
            case "numberColor":
                return .systemBlue
            case "stringColor":
                return .systemOrange
            case "identifierColor":
                return .systemIndigo
            case "keywordColor":
                return .systemPurple
            case "commentColor":
                return .systemGray
            default:
                return .clear
            }
        }
        return toNativeColor()
    }
    
}
