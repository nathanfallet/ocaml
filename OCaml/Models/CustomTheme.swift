//
//  CustomTheme.swift
//  OCaml
//
//  Created by Nathan FALLET on 05/01/2021.
//

import UIKit
import Sourceful

struct CustomTheme: SourceCodeTheme {
    
    let font: UIFont = .monospacedSystemFont(ofSize: 14, weight: .regular)
    
    let backgroundColor: UIColor = .systemBackground
    
    let lineNumbersStyle: LineNumbersStyle? = .init(
        font: .monospacedSystemFont(ofSize: 14, weight: .regular),
        textColor: UIColor.tertiaryLabel
    )
    
    let gutterStyle: GutterStyle = .init(
        backgroundColor: .systemBackground,
        minimumWidth: 30
    )
    
    func globalAttributes() -> [NSAttributedString.Key: Any] {
        var attributes = [NSAttributedString.Key: Any]()
        
        attributes[.font] = font
        attributes[.foregroundColor] = UIColor.label
        
        return attributes
    }
    
    func color(for syntaxColorType: SourceCodeTokenType) -> UIColor {
        switch syntaxColorType {
            case .plain: return .label
            case .number: return .systemBlue
            case .string: return .systemOrange
            case .identifier: return .systemIndigo
            case .keyword: return .systemPurple
            case .comment: return .systemGray
            case .editorPlaceholder: return .systemGray
        }
    }
    
}
