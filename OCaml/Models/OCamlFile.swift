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

class OCamlFile {
    
    // File properties
    var url: URL?
    var source = ""
    
    // File status
    var edited = false
    
    // File name
    var name: String? {
        if let url = url {
            return url.lastPathComponent
        } else {
            return nil
        }
    }
    
    // Load file content
    func load(from url: URL) -> Bool {
        // Start accessing a security-scoped resource.
        let _ = url.startAccessingSecurityScopedResource()
        defer { url.stopAccessingSecurityScopedResource() }
        
        // Try to load file content
        if let source = try? String(contentsOf: url) {
            // Save URL and source
            self.url = url
            self.source = source
            
            // Ok
            return true
        }
        
        // Failed
        return false
    }
    
    // Change file content
    func update(source: String) {
        // Update status
        if self.source != source {
            // Mark as edited
            self.source = source
            self.edited = true
        }
    }
    
    // Save the file to disk
    @discardableResult
    func save() -> Bool {
        // Check if a file is linked
        if let url = url {
            // Start accessing a security-scoped resource.
            let _ = url.startAccessingSecurityScopedResource()
            defer { url.stopAccessingSecurityScopedResource() }
            
            // Save file content
            try? source.write(to: url, atomically: true, encoding: .utf8)
            self.edited = false
            
            // Saved
            return true
        }
        
        // No file found, ask for a location
        return false
    }
    
}
