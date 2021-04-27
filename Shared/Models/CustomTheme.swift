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

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

import Sourceful

class CustomTheme: SourceCodeTheme {
    
    // Static shared instance for the app
    static let shared = CustomTheme()
    
    // Store colors
    var backgroundColor: NativeColor = .clear
    var plainColor: NativeColor = .clear
    var numberColor: NativeColor = .clear
    var stringColor: NativeColor = .clear
    var identifierColor: NativeColor = .clear
    var keywordColor: NativeColor = .clear
    var commentColor: NativeColor = .clear
    
    // Store font
    let font: NativeFont = .monospacedSystemFont(ofSize: 14, weight: .regular)
    
    // Private initializer
    private init() {
        // Just load colors
        loadColors()
    }
    
    func loadColors() {
        // First we get saved properties (or standard if not available)
        let datas = UserDefaults(suiteName: "group.me.nathanfallet.ocaml") ?? .standard
        
        // Then we get colors (or defaults if not customized)
        backgroundColor = (datas.value(forKey: "backgroundColor") as? Int)?.toNativeColor() ?? .systemBackground
        plainColor = (datas.value(forKey: "plainColor") as? Int)?.toNativeColor() ?? .label
        numberColor = (datas.value(forKey: "numberColor") as? Int)?.toNativeColor() ?? .systemBlue
        stringColor = (datas.value(forKey: "stringColor") as? Int)?.toNativeColor() ?? .systemOrange
        identifierColor = (datas.value(forKey: "identifierColor") as? Int)?.toNativeColor() ?? .systemIndigo
        keywordColor = (datas.value(forKey: "keywordColor") as? Int)?.toNativeColor() ?? .systemPurple
        commentColor = (datas.value(forKey: "commentColor") as? Int)?.toNativeColor() ?? .systemGray
    }
    
    // Some styles
    let lineNumbersStyle: LineNumbersStyle? = .init(
        font: .monospacedSystemFont(ofSize: 14, weight: .regular),
        textColor: NativeColor.tertiaryLabel
    )
    
    let gutterStyle: GutterStyle = .init(
        backgroundColor: .systemBackground,
        minimumWidth: 30
    )
    
    // Attribute getter
    func globalAttributes() -> [NSAttributedString.Key: Any] {
        var attributes = [NSAttributedString.Key: Any]()
        
        attributes[.font] = font
        attributes[.foregroundColor] = NativeColor.label
        
        return attributes
    }
    
    // Return colors for types
    func color(for syntaxColorType: SourceCodeTokenType) -> NativeColor {
        switch syntaxColorType {
            case .plain: return plainColor
            case .number: return numberColor
            case .string: return stringColor
            case .identifier: return identifierColor
            case .keyword: return keywordColor
            case .comment: return commentColor
            case .editorPlaceholder: return .systemGray
        }
    }
    
}
