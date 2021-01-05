//
//  StringExtension.swift
//  OCaml
//
//  Created by Nathan FALLET on 05/01/2021.
//

import Foundation

extension String {
    
    // Localization
        
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }

    func format(_ args : CVarArg...) -> String {
        return String(format: self, locale: .current, arguments: args)
    }

    func format(_ args : [String]) -> String {
        return String(format: self, locale: .current, arguments: args)
    }
    
}
