//
//  CustomTheme.swift
//  OCaml
//
//  Created by Nathan FALLET on 05/01/2021.
//

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
        numberColor = (datas.value(forKey: "numberColor") as? Int)?.toUIColor() ?? .systemYellow
        stringColor = (datas.value(forKey: "stringColor") as? Int)?.toUIColor() ?? .systemRed
        identifierColor = (datas.value(forKey: "identifierColor") as? Int)?.toUIColor() ?? .systemTeal
        keywordColor = (datas.value(forKey: "keywordColor") as? Int)?.toUIColor() ?? .systemPurple
        commentColor = (datas.value(forKey: "commentColor") as? Int)?.toUIColor() ?? .systemGreen
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
