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

struct ConsoleEntry: Equatable, Hashable, Identifiable {
    
    enum Level: Int {
        case log = 0
        case warn = 1
        case error = 2
    }
    
    enum Format: Int {
        case other = 0
        case string = 1
        case number = 2
        case boolean = 3
        case null = 4
        case undefined = 5
        case array = 6
        case object = 7
        case list = 8
    }
    
    struct Value: Equatable, Hashable, Identifiable, CustomStringConvertible {
        let id = UUID()
        let description: String
        let format: Format
    }
    
    struct Part: Equatable, Hashable, Identifiable {
        let id = UUID()
        let label: Value
        let alternate: [Value]?
    }
    
    let id = UUID()
    let level: Level
    let parts: [Part]
    
}

extension ConsoleEntry: CustomStringConvertible {
    var description: String {
        self.parts.map{ $0.label.description }.joined(separator: "\n")
    }
}

extension ConsoleEntry.Level: CustomStringConvertible {
    var description: String {
        switch self {
            case .log: return "log"
            case .warn: return "warn"
            case .error: return "error"
        }
    }
}

extension ConsoleEntry.Format: CustomStringConvertible {
    var description: String {
        switch self {
            case .other: return "Other"
            case .string: return "String"
            case .number: return "Number"
            case .boolean: return "Boolean"
            case .null: return "Null"
            case .undefined: return "Undefined"
            case .array: return "Array"
            case .object: return "Object"
            case .list: return "List"
        }
    }
}
