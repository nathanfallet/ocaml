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

    func escapeCode() -> String {
        replacingOccurrences(of: "`", with: "\\`")
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

    func splitInSpans() -> [(Int, String, String)] {
        var spans = [(Int, String, String)]()
        for group in groups(for: #"<span class=\"([a-z]+)\">([^<>]+)</span>"#) {
            spans.append((spans.count, group[1], group[2].trimEndlines()))
        }
        return spans
    }

}
