//
//  CustomSyntaxTextView.swift
//  OCaml
//
//  Created by Nathan FALLET on 05/01/2021.
//

import UIKit
import Sourceful

class CustomSyntaxTextView: SyntaxTextView, SyntaxTextViewDelegate {
    
    var margin: CGFloat { shouldAddMargin ? 10 : 0 }
    var shouldAddMargin = true
    
    func setup() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        contentInset = .init(top: margin, left: 0, bottom: margin, right: 0)
        
        delegate = self
        theme = CustomTheme.shared
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardDidShow(aNotification: NSNotification) {
        let info = aNotification.userInfo
        let infoNSValue = info![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        let keyboardFrame = infoNSValue.cgRectValue.size
        let bottom = max(keyboardFrame.height - safeAreaInsets.bottom, 0)
        contentInset = .init(top: margin, left: 0, bottom: bottom + margin, right: 0)
    }

    @objc func keyboardWillHide(aNotification:NSNotification) {
        contentInset = .init(top: margin, left: 0, bottom: margin, right: 0)
    }
    
    func lexerForSource(_ source: String) -> Lexer {
        return OCamlLexer()
    }
    
}
