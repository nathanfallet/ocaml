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
import DigiAnalytics

struct MainWindow: View {

    @Environment(\.openURL) var openURL
    @AppStorage("firstOpen") var firstOpen = true

    @StateObject var consoleViewModel = ConsoleViewModel()
    @Binding var document: OCamlFile
    @Binding var showSettings: Bool

    func initAnalytics() {
        // Send firstOpen if needed
        if firstOpen {
            DigiAnalytics.shared.send(path: "firstOpen")
            firstOpen = false
        }

        // Send file open
        DigiAnalytics.shared.send(path: "fileOpen")
    }

    var body: some View {
        CodeView(
            consoleViewModel: consoleViewModel,
            document: $document
        )
        .onAppear {
            initAnalytics()
            consoleViewModel.loadConsoleIfNeeded()
        }
        .toolbar {
            ToolbarItemGroup(placement: placement) {
                Button(
                    action: {
                        if let url = URL(string: "https://ocaml-learn-code.com/learn") {
                            openURL(url)
                        }
                    },
                    label: {
                        Image(systemName: "book")
                    }
                )
                Button(
                    action: {
                        #if os(macOS)
                        NSApp.sendAction(Selector(("showPreferencesWindow:")), to: nil, from: nil)
                        #else
                        showSettings = true
                        #endif
                    },
                    label: {
                        Image(systemName: "gearshape")
                    }
                )
                Button(
                    action: {
                        consoleViewModel.showConsole.toggle()
                        consoleViewModel.execute(document.source)
                    },
                    label: {
                        Image(systemName: "play")
                    }
                )
            }
        }
    }

    var placement: ToolbarItemPlacement {
        #if os(macOS)
        return .primaryAction
        #else
        return .navigationBarLeading
        #endif
    }

}
