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

struct SettingsView: View {
    @Environment(\.openURL) var openURL
    
    var body: some View {
        List {
            Section(header: Text("editor_settings")) {
                EditorColorView(name: "backgroundColor", color: CustomTheme.shared.backgroundColor.toColor())
                EditorColorView(name: "plainColor", color: CustomTheme.shared.plainColor.toColor())
                EditorColorView(name: "numberColor", color: CustomTheme.shared.numberColor.toColor())
                EditorColorView(name: "stringColor", color: CustomTheme.shared.stringColor.toColor())
                EditorColorView(name: "identifierColor", color: CustomTheme.shared.identifierColor.toColor())
                EditorColorView(name: "keywordColor", color: CustomTheme.shared.keywordColor.toColor())
                EditorColorView(name: "commentColor", color: CustomTheme.shared.commentColor.toColor())
            }
            
            Section(header: Text("about")) {
                Text("developer_text")
                    .onTapGesture {
                        if let url = URL(string: "https://www.nathanfallet.me/") {
                            openURL(url)
                        }
                    }
                NavigationLink(destination: OpenSourceView()) {
                    Text("opensource")
                }
                Text("donate_title")
            }
            
            Section(header: Text("apps")) {
                AppView(name: "Delta: Algorithms", description: "delta", image: "Delta")
                    .onTapGesture {
                        if let url = URL(string: "https://apps.apple.com/app/delta-algorithms/id1436506800") {
                            openURL(url)
                        }
                    }
                AppView(name: "BaseConverter: All in one", description: "baseconverter", image: "BaseConverter")
                    .onTapGesture {
                        if let url = URL(string: "https://apps.apple.com/app/baseconverter-all-in-one/id1446344899") {
                            openURL(url)
                        }
                    }
            }
        }
        .navigationTitle("settings")
        .listStyle(InsetGroupedListStyle())
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
