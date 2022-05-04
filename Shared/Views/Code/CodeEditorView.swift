/*
*  Copyright (C) 2022 Groupe MINASTE
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

public struct CodeEditorView: NativeViewRepresentable {

    @Environment(\.backgroundColor) var backgroundColor
    @Environment(\.plainColor) var plainColor
    @Environment(\.numberColor) var numberColor
    @Environment(\.stringColor) var stringColor
    @Environment(\.identifierColor) var identifierColor
    @Environment(\.keywordColor) var keywordColor
    @Environment(\.commentColor) var commentColor

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
        _ = view.becomeFirstResponder()
    }
    #endif

    #if os(macOS)
    public func makeNSView(context: Context) -> SyntaxTextView {
        let wrappedView = makeView(context: context)
        wrappedView.contentTextView.insertionPointColor = Sourceful.Color.white
        return wrappedView
    }

    public func updateNSView(_ view: SyntaxTextView, context: Context) {

    }
    #endif

    private func makeView(context: Context) -> SyntaxTextView {
        let wrappedView = SyntaxTextView()
        wrappedView.delegate = context.coordinator
        wrappedView.theme = context.coordinator
        #if !os(macOS)
        wrappedView.contentInset = .init(top: 10, left: 0, bottom: 10, right: 0)
        #endif

        context.coordinator.wrappedView = wrappedView
        context.coordinator.wrappedView.text = text

        if readOnly {
            wrappedView.contentTextView.isEditable = false
            #if !os(macOS)
            wrappedView.contentTextView.isScrollEnabled = true
            wrappedView.clipsToBounds = true
            wrappedView.layer.cornerRadius = 8
            #endif
        }

        return wrappedView
    }

}

extension CodeEditorView {

    public class Coordinator: SourceCodeTheme, SyntaxTextViewDelegate {
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

        // Colors
        public var backgroundColor: Sourceful.Color {
            parent.backgroundColor.wrappedValue.toNativeColorOrDefault(for: "backgroundColor")
        }
        public var plainColor: Sourceful.Color {
            parent.plainColor.wrappedValue.toNativeColorOrDefault(for: "plainColor")
        }
        public var numberColor: Sourceful.Color {
            parent.numberColor.wrappedValue.toNativeColorOrDefault(for: "numberColor")
        }
        public var stringColor: Sourceful.Color {
            parent.stringColor.wrappedValue.toNativeColorOrDefault(for: "stringColor")
        }
        public var identifierColor: Sourceful.Color {
            parent.identifierColor.wrappedValue.toNativeColorOrDefault(for: "identifierColor")
        }
        public var keywordColor: Sourceful.Color {
            parent.keywordColor.wrappedValue.toNativeColorOrDefault(for: "keywordColor")
        }
        public var commentColor: Sourceful.Color {
            parent.commentColor.wrappedValue.toNativeColorOrDefault(for: "commentColor")
        }

        // Store font
        public let font: Sourceful.Font = .monospacedSystemFont(ofSize: 14, weight: .regular)

        // Some styles
        public let lineNumbersStyle: LineNumbersStyle? = .init(
            font: .monospacedSystemFont(ofSize: 14, weight: .regular),
            textColor: NativeColor.tertiaryLabel
        )

        public let gutterStyle: GutterStyle = .init(
            backgroundColor: .systemBackground,
            minimumWidth: 30
        )

        // Attribute getter
        public func globalAttributes() -> [NSAttributedString.Key: Any] {
            var attributes = [NSAttributedString.Key: Any]()

            attributes[.font] = font
            attributes[.foregroundColor] = NativeColor.label

            return attributes
        }

        // Return colors for types
        public func color(for syntaxColorType: SourceCodeTokenType) -> Sourceful.Color {
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
}

struct CodeEditorView_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        CodeEditorView(text: .constant(""))
    }
}
