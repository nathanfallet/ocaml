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

import SwiftUI

#if os(macOS)
public typealias NativeViewRepresentable = NSViewRepresentable
#endif

#if os(iOS)
public typealias NativeViewRepresentable = UIViewRepresentable
#endif

extension View {

    func listStyleInsetGroupedIfAvailable() -> some View {
        #if os(macOS)
        return Form { self }
        #else
        return self.listStyle(InsetGroupedListStyle())
        #endif
    }

    func autocapitalizationNoneIfAvailable() -> some View {
        #if os(iOS)
        return self.autocapitalization(UITextAutocapitalizationType.none)
        #else
        return self
        #endif
    }

}

#if os(macOS)
extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get { .none }
        set { super.focusRingType = newValue }
    }
}
#endif
