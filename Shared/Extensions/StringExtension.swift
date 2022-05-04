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

import Foundation

extension String {

    // Localization

    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }

    func format(_ args: CVarArg...) -> String {
        return String(format: self, locale: .current, arguments: args)
    }

    func format(_ args: [String]) -> String {
        return String(format: self, locale: .current, arguments: args)
    }

    // Code escape

    func removeComments() -> String {
        // Need to optimize this (takes too much time for long files)
        // and also check for strings (don't remove content in strings)
        var new = ""
        var comment = false
        var i = 0
        while i < count {
            if self[i] == "(" && i+1 < count && self[i+1] == "*" {
                comment = true
            }
            if self[i] == "*" && i+1 < count && self[i+1] == ")" {
                comment = false
                i += 2
            }
            if !comment {
                new += self[i]
            }
            i += 1
        }
        return new
    }

    func escapeCode() -> String {
        return replacingOccurrences(of: "\\", with: "\\\\")
            .replacingOccurrences(of: "`", with: "\\`")
    }

    func trimEndlines() -> String {
        var new = self
        while new.first == "\n" {
            new.removeFirst()
        }
        while new.last == "\n" {
            new.removeLast()
        }
        return new
    }

    func replaceHTMLChars() -> String {
        return replacingOccurrences(of: "&lt;", with: "<")
            .replacingOccurrences(of: "&gt;", with: ">")
            .replacingOccurrences(of: "&amp;", with: "&")
    }

    // Regex

    func groups(for regexPattern: String) -> [[String]] {
        do {
            let text = self
            let regex = try NSRegularExpression(pattern: regexPattern, options: [.dotMatchesLineSeparators])
            let matches = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
            return matches.map { match in
                return (0..<match.numberOfRanges).map {
                    let rangeBounds = match.range(at: $0)
                    guard let range = Range(rangeBounds, in: text) else {
                        return ""
                    }
                    return String(text[range])
                }
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }

    func splitInSpans() -> [ConsoleEntry] {
        var spans = [ConsoleEntry]()
        for group in groups(for: #"<span class=\"([a-z]+)\">([^<>]+)</span>"#) {
            let content = group[2].trimEndlines().replaceHTMLChars()
            if !content.isEmpty {
                spans.append(ConsoleEntry(id: spans.count, span: group[1], content: content))
            }
        }
        return spans
    }

    // Subscript

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, count) ..< count]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(count, r.lowerBound)), upper: min(count, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }

}
