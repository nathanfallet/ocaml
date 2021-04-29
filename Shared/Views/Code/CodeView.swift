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

struct CodeView: View {
    @ObservedObject var consoleViewModel: ConsoleViewModel
    @Binding var document: OCamlFile

    var body: some View {
        SplitView(
            leftView: {
                CodeEditorView(text: $document.source)
                    .ignoresSafeArea(.container, edges: .bottom)
            }, rightView: {
                ConsoleView(viewModel: consoleViewModel)
            },
            rightTitle: "console".localized(),
            showRightView: $consoleViewModel.showConsole
        )
    }
}

struct CodeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CodeView(consoleViewModel: ConsoleViewModel(), document: .constant(OCamlFile()))
                .previewDevice("iPad (8th generation)")
        }
    }
}
