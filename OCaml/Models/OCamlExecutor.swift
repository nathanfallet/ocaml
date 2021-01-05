//
//  OCamlExecutor.swift
//  OCaml
//
//  Created by Nathan FALLET on 05/01/2021.
//

import Foundation
import JavaScriptCore

class OCamlExecutor {
    
    private var jsContext = JSContext()
    
    init() {
        // Load javascript build
        if let url = Bundle.main.url(forResource: "main", withExtension: "js"),
            let source = try? String(contentsOf: url) {
            jsContext?.evaluateScript(source)
        }
    }
    
}
