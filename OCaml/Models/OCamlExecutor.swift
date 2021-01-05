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
    
    public func compile(source: String, completionHandler: @escaping (String?, ExecutorError?) -> ()) {
        // Compile the OCaml source to JavaScript
        guard !source.contains("//") else {
            // Crashes the JS engine
            completionHandler(nil, .commentsNotSupported)
            return
        }
        
        // Call the compile method from js
        guard let jsContext = self.jsContext,
            let window = jsContext.globalObject,
            let runtime = window.objectForKeyedSubscript("javascript"),
            let out = runtime.invokeMethod(
                "compile",
                withArguments: ["ml", source]
            ),
            let errors = out.objectAtIndexedSubscript(0),
            let javascript = out.objectAtIndexedSubscript(1) else {
            // Error with js context
            completionHandler(nil, .jsContextError)
            return
        }
        
        // Check result
        if errors.isNull && javascript.isString {
            // Fine
            completionHandler(javascript.toString(), nil)
        } else if errors.isString {
            // Error
            completionHandler(nil, .fromJS(errors.toString()))
        } else {
            // Unknown error
            completionHandler(nil, nil)
        }
    }
    
    public func run(javascript: String, completionHandler: @escaping ([ConsoleEntry]) -> ()) {
        // Eval javascript
        guard !javascript.isEmpty,
            let jsContext = self.jsContext,
            let window = jsContext.globalObject,
            let runtime = window.objectForKeyedSubscript("javascript"),
            let out = runtime.invokeMethod(
                "evalScript",
                withArguments: [javascript]
            ),
            let console = out.toArray() else {
            completionHandler([])
            return
        }
        
        // Pass response to completion handler
        completionHandler(console.compactMap { entry -> ConsoleEntry? in
            guard let entry = entry as? NSDictionary,
                let levelInt = entry["level"] as? Int,
                let level = ConsoleEntry.Level(rawValue: levelInt),
                let partsArray = entry["parts"] as? [Any] else {
                return nil
            }
            
            let parts = partsArray.compactMap { part -> ConsoleEntry.Part? in
                guard let part = part as? NSDictionary,
                    let labelDict = part["label"] as? NSDictionary,
                    let label = self.consoleValue(from: labelDict) else {
                    return nil
                }
                
                let alternate = (part["alternate"] as? NSArray)?
                    .compactMap { self.consoleValue(from: $0) }
                
                return ConsoleEntry.Part(label: label, alternate: alternate)
            }
            
            return ConsoleEntry(level: level, parts: parts)
        })
    }
    
    private func consoleValue(from arg: Any) -> ConsoleEntry.Value? {
        // Parse a console value
        guard let argDict = arg as? NSDictionary,
            let formatInt = argDict["format"] as? Int,
            let format = ConsoleEntry.Format(rawValue: formatInt),
            let description = argDict["description"] as? String else {
            return nil
        }
        
        return ConsoleEntry.Value(description: description, format: format)
    }
    
}

enum ExecutorError {
    
    case commentsNotSupported
    case jsContextError
    case fromJS(String)

}
