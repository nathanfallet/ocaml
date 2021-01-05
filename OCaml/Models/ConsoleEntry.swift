//
//  ConsoleEntry.swift
//  OCaml
//
//  Created by Nathan FALLET on 05/01/2021.
//

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
