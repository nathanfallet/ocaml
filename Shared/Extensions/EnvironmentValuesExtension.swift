/*
*  Copyright (C) 2023 Nathan Fallet
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

private struct BackgroundColorKey: EnvironmentKey {
    static let defaultValue = Binding.constant(-1)
}
private struct PlainColorKey: EnvironmentKey {
    static let defaultValue = Binding.constant(-1)
}
private struct NumberColorKey: EnvironmentKey {
    static let defaultValue = Binding.constant(-1)
}
private struct StringColorKey: EnvironmentKey {
    static let defaultValue = Binding.constant(-1)
}
private struct IdentifierColorKey: EnvironmentKey {
    static let defaultValue = Binding.constant(-1)
}
private struct KeywordColorKey: EnvironmentKey {
    static let defaultValue = Binding.constant(-1)
}
private struct CommentColorKey: EnvironmentKey {
    static let defaultValue = Binding.constant(-1)
}

extension EnvironmentValues {
    var backgroundColor: Binding<Int> {
        get { self[BackgroundColorKey.self] }
        set { self[BackgroundColorKey.self] = newValue }
    }
    var plainColor: Binding<Int> {
        get { self[PlainColorKey.self] }
        set { self[PlainColorKey.self] = newValue }
    }
    var numberColor: Binding<Int> {
        get { self[NumberColorKey.self] }
        set { self[NumberColorKey.self] = newValue }
    }
    var stringColor: Binding<Int> {
        get { self[StringColorKey.self] }
        set { self[StringColorKey.self] = newValue }
    }
    var identifierColor: Binding<Int> {
        get { self[IdentifierColorKey.self] }
        set { self[IdentifierColorKey.self] = newValue }
    }
    var keywordColor: Binding<Int> {
        get { self[KeywordColorKey.self] }
        set { self[KeywordColorKey.self] = newValue }
    }
    var commentColor: Binding<Int> {
        get { self[CommentColorKey.self] }
        set { self[CommentColorKey.self] = newValue }
    }
}
