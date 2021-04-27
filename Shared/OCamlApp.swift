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

@main
struct OCamlApp: App {
    @StateObject var consoleViewModel = ConsoleViewModel()
    @State var activeSheet: ActiveSheet?
    
    #if os(iOS)
    var body: some Scene {
        // Main document group
        DocumentGroup(newDocument: OCamlFile()) { file in
            CodeView(
                consoleViewModel: consoleViewModel,
                document: file.$document
            )
                .onAppear {
                    consoleViewModel.loadConsoleIfNeeded()
                }
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(action: {
                            activeSheet = .learn
                        }) {
                            Image(systemName: "book")
                        }
                        Button(action: {
                            activeSheet = .settings
                        }) {
                            Image(systemName: "gearshape")
                        }
                        Button(action: {
                            consoleViewModel.showConsole.toggle()
                            consoleViewModel.execute(file.document.source)
                        }) {
                            Image(systemName: "play")
                        }
                    }
                }
                .fullScreenCover(item: $activeSheet) { item in
                    switch item {
                    case .learn:
                        NavigationView {
                            LearnView()
                                .toolbar {
                                    ToolbarItemGroup(placement: .cancellationAction) {
                                        Button(action: {
                                            activeSheet = nil
                                        }) {
                                            Image(systemName: "xmark.circle")
                                        }
                                    }
                                }
                        }
                        .navigationViewStyle(StackNavigationViewStyle())
                    case .settings:
                        NavigationView {
                            SettingsView()
                                .toolbar {
                                    ToolbarItemGroup(placement: .cancellationAction) {
                                        Button(action: {
                                            activeSheet = nil
                                        }) {
                                            Image(systemName: "xmark.circle")
                                        }
                                    }
                                }
                        }
                        .navigationViewStyle(StackNavigationViewStyle())
                    }
                }
        }
    }
    #endif
    
    #if os(macOS)
    var body: some Scene {
        // Main document group
        DocumentGroup(newDocument: OCamlFile()) { file in
            CodeView(
                consoleViewModel: consoleViewModel,
                document: file.$document
            )
                .onAppear {
                    consoleViewModel.loadConsoleIfNeeded()
                }
                .toolbar {
                    ToolbarItemGroup(placement: .primaryAction) {
                        Button(action: {
                            activeSheet = .learn
                        }) {
                            Image(systemName: "book")
                        }
                        Button(action: {
                            activeSheet = .settings
                        }) {
                            Image(systemName: "gearshape")
                        }
                        Button(action: {
                            consoleViewModel.showConsole.toggle()
                            consoleViewModel.execute(file.document.source)
                        }) {
                            Image(systemName: "play")
                        }
                    }
                }
        }
        
        // Settings
        Settings {
            SettingsView()
        }
    }
    #endif
    
}

enum ActiveSheet: Identifiable {
    case learn
    case settings
    
    var id: Int { hashValue }
}
