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

struct EditorColorView: View {
    @State var name: String
    @State var color: Color
    @State var presentPicker: Bool = false
    
    var body: some View {
        ColorPicker(name.localized(), selection: $color)
            .onChange(of: color) { newValue in
                // Save new color
                let datas = UserDefaults(suiteName: "group.me.nathanfallet.ocaml") ?? .standard
                datas.setValue(newValue.toInt(), forKey: name)
                datas.synchronize()
                
                // Reload theme
                CustomTheme.shared.loadColors()
            }
    }
}

struct EditorColorView_Previews: PreviewProvider {
    static var previews: some View {
        EditorColorView(name: "backgroundColor", color: .green)
    }
}
