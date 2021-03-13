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
import Sourceful

class CustomTheme: SourceCodeTheme {
    
    // Static shared instance for the app
    static let shared = CustomTheme()
    
    // Store colors
    var backgroundColor: UIColor = .clear
    var plainColor: UIColor = .clear
    var numberColor: UIColor = .clear
    var stringColor: UIColor = .clear
    var identifierColor: UIColor = .clear
    var keywordColor: UIColor = .clear
    var commentColor: UIColor = .clear
    
    // Store font
    let font: UIFont = .monospacedSystemFont(ofSize: 14, weight: .regular)
    
    // Private initializer
    private init() {
        // Just load colors
        loadColors()
    }
    
    func loadColors() {
        // First we get saved properties (or standard if not available)
        let datas = UserDefaults(suiteName: "group.me.nathanfallet.ocaml") ?? .standard
        
        // Then we get colors (or defaults if not customized)
        backgroundColor = (datas.value(forKey: "backgroundColor") as? Int)?.toUIColor() ?? .systemBackground
        plainColor = (datas.value(forKey: "plainColor") as? Int)?.toUIColor() ?? .label
        numberColor = (datas.value(forKey: "numberColor") as? Int)?.toUIColor() ?? .systemBlue
        stringColor = (datas.value(forKey: "stringColor") as? Int)?.toUIColor() ?? .systemOrange
        identifierColor = (datas.value(forKey: "identifierColor") as? Int)?.toUIColor() ?? .systemIndigo
        keywordColor = (datas.value(forKey: "keywordColor") as? Int)?.toUIColor() ?? .systemPurple
        commentColor = (datas.value(forKey: "commentColor") as? Int)?.toUIColor() ?? .systemGray
    }
    
    // Some styles
    let lineNumbersStyle: LineNumbersStyle? = .init(
        font: .monospacedSystemFont(ofSize: 14, weight: .regular),
        textColor: UIColor.tertiaryLabel
    )
    
    let gutterStyle: GutterStyle = .init(
        backgroundColor: .systemBackground,
        minimumWidth: 30
    )
    
    // Attribute getter
    func globalAttributes() -> [NSAttributedString.Key: Any] {
        var attributes = [NSAttributedString.Key: Any]()
        
        attributes[.font] = font
        attributes[.foregroundColor] = UIColor.label
        
        return attributes
    }
    
    // Return colors for types
    func color(for syntaxColorType: SourceCodeTokenType) -> UIColor {
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
