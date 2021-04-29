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
import WebKit

struct ConsoleView: View {
    @ObservedObject var viewModel: ConsoleViewModel
    @State var currentLine: String = ""
    let id = UUID()

    var body: some View {
        if viewModel.showLoading {
            VStack(spacing: 16) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                Text("console_load")
            }
        } else {
            VStack(spacing: 0) {
                ScrollView {
                    ScrollViewReader { value in
                        VStack(alignment: .leading) {
                            Text(viewModel.output ?? "console_failed".localized())
                            if viewModel.showExecuting {
                                HStack {
                                    Spacer()
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle())
                                    Spacer()
                                }
                            }
                        }
                        .id(id)
                        .padding()
                        .fixedSize(horizontal: false, vertical: true)
                        .onChange(of: viewModel.output, perform: { _ in
                            withAnimation {
                                value.scrollTo(id, anchor: .bottom)
                            }
                        })
                    }
                }
                HStack(alignment: .top) {
                    Text("#")
                    TextField("", text: $currentLine, onCommit: {
                        viewModel.execute(currentLine)
                        currentLine = ""
                    })
                    .autocapitalizationNoneIfAvailable()
                    .disableAutocorrection(true)
                    .background(Color.clear)
                }
                .padding()
                .background(NativeColor.systemBackground.toColor())
            }
            .font( .system(size: 14, design: .monospaced))
            .alert(isPresented: Binding<Bool>(
                get: {
                    viewModel.prompt != nil
                },
                set: {
                    if !$0 {
                        viewModel.prompt = nil
                    }
                }
            )) {
                Alert(
                    title: Text(viewModel.prompt ?? ""),
                    message: nil,
                    primaryButton: .default(Text("button_ok"), action: {
                        viewModel.promptCompletionHandler?(nil)
                    }),
                    secondaryButton: .destructive(Text("button_cancel"), action: {
                        viewModel.promptCompletionHandler?(nil)
                    })
                )
            }
        }
    }
}

struct ConsoleView_Previews: PreviewProvider {
    static var previews: some View {
        ConsoleView(viewModel: ConsoleViewModel())
    }
}
