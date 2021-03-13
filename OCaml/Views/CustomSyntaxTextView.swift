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
