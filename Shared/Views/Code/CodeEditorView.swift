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

import Sourceful
import SwiftUI

public struct CodeEditorView: _ViewRepresentable {
    
    @Binding var text: String
    var readOnly: Bool = false
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    #if os(iOS)
    public func makeUIView(context: Context) -> SyntaxTextView {
        makeView(context: context)
    }
    
    public func updateUIView(_ view: SyntaxTextView, context: Context) {
        let _ = view.becomeFirstResponder()
    }
    #endif
    
    #if os(macOS)
    public func makeNSView(context: Context) -> SyntaxTextView {
        let wrappedView = makeView(context: context)
        wrappedView.contentTextView.insertionPointColor = Sourceful.color.white
        return wrappedView
    }
    
    public func updateNSView(_ view: SyntaxTextView, context: Context) {
       
    }
    #endif
    
    private func makeView(context: Context) -> SyntaxTextView {
        let wrappedView = SyntaxTextView()
        wrappedView.delegate = context.coordinator
        wrappedView.theme = CustomTheme.shared
        wrappedView.contentInset = .init(top: 10, left: 0, bottom: 10, right: 0)
        
        context.coordinator.wrappedView = wrappedView
        context.coordinator.wrappedView.text = text
        
        if readOnly {
            wrappedView.contentTextView.isEditable = false
            wrappedView.contentTextView.isScrollEnabled = true
            wrappedView.clipsToBounds = true
            wrappedView.layer.cornerRadius = 8
        }
        
        return wrappedView
    }
    
}

extension CodeEditorView {
    
    public class Coordinator: SyntaxTextViewDelegate {
        let parent: CodeEditorView
        var wrappedView: SyntaxTextView!
        
        init(_ parent: CodeEditorView) {
            self.parent = parent
        }
        
        public func lexerForSource(_ source: String) -> Lexer {
            OCamlLexer()
        }
        
        public func didChangeText(_ syntaxTextView: SyntaxTextView) {
            DispatchQueue.main.async {
                self.parent.text = syntaxTextView.text
            }
        }
        
        public func textViewDidBeginEditing(_ syntaxTextView: SyntaxTextView) {
            
        }
    }
}

struct CodeEditorView_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        CodeEditorView(text: .constant(""))
    }
}
