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

import SwiftUI
import UniformTypeIdentifiers

struct OCamlFile: FileDocument {
    
    // File content
    var source = ""
    
    // Supported identifiers
    static var readableContentTypes: [UTType] {
        guard let identifier = UTType("public.ocaml") else { return [] }
        return [identifier]
    }
    
    // Init a new empty file
    init(source: String = "") {
        self.source = source
    }
    
    // Init a file from configuration
    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            source = String(decoding: data, as: UTF8.self)
        } else {
            throw CocoaError(.fileReadCorruptFile)
        }
    }
    
    // Save file
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = Data(source.utf8)
        return FileWrapper(regularFileWithContents: data)
    }
    
}
