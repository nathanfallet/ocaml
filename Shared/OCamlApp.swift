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

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

@main
struct OCamlApp: App {

    // MARK: - App properties

    @AppStorage("backgroundColor") var backgroundColor = -1
    @AppStorage("plainColor") var plainColor = -1
    @AppStorage("numberColor") var numberColor = -1
    @AppStorage("stringColor") var stringColor = -1
    @AppStorage("identifierColor") var identifierColor = -1
    @AppStorage("keywordColor") var keywordColor = -1
    @AppStorage("commentColor") var commentColor = -1

    @State var showSettings = false

    // MARK: - Scenes

    #if os(iOS)
    var body: some Scene {
        // Main document group
        DocumentGroup(newDocument: OCamlFile()) { file in
            MainWindow(document: file.$document, showSettings: $showSettings)
                .environment(\.backgroundColor, $backgroundColor)
                .environment(\.plainColor, $plainColor)
                .environment(\.numberColor, $numberColor)
                .environment(\.stringColor, $stringColor)
                .environment(\.identifierColor, $identifierColor)
                .environment(\.keywordColor, $keywordColor)
                .environment(\.commentColor, $commentColor)
                .fullScreenCover(isPresented: $showSettings) {
                    NavigationView {
                        SettingsView()
                            .environment(\.backgroundColor, $backgroundColor)
                            .environment(\.plainColor, $plainColor)
                            .environment(\.numberColor, $numberColor)
                            .environment(\.stringColor, $stringColor)
                            .environment(\.identifierColor, $identifierColor)
                            .environment(\.keywordColor, $keywordColor)
                            .environment(\.commentColor, $commentColor)
                            .toolbar {
                                ToolbarItemGroup(placement: .cancellationAction) {
                                    Button(
                                        action: {
                                            showSettings = false
                                        },
                                        label: {
                                            Image(systemName: "xmark.circle")
                                        }
                                    )
                                }
                            }
                    }
                    .navigationViewStyle(StackNavigationViewStyle())
                }
        }
    }
    #endif

    #if os(macOS)
    var body: some Scene {
        // Main document group
        DocumentGroup(newDocument: OCamlFile()) { file in
            MainWindow(document: file.$document, showSettings: $showSettings)
                .environment(\.backgroundColor, $backgroundColor)
                .environment(\.plainColor, $plainColor)
                .environment(\.numberColor, $numberColor)
                .environment(\.stringColor, $stringColor)
                .environment(\.identifierColor, $identifierColor)
                .environment(\.keywordColor, $keywordColor)
                .environment(\.commentColor, $commentColor)
        }

        // Settings
        Settings {
            SettingsView()
                .environment(\.backgroundColor, $backgroundColor)
                .environment(\.plainColor, $plainColor)
                .environment(\.numberColor, $numberColor)
                .environment(\.stringColor, $stringColor)
                .environment(\.identifierColor, $identifierColor)
                .environment(\.keywordColor, $keywordColor)
                .environment(\.commentColor, $commentColor)
        }
    }
    #endif

}
