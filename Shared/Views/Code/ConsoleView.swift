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

/*public struct ConsoleView: _ViewRepresentable {
    
    @ObservedObject var viewModel: ConsoleViewModel
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    #if os(iOS)
    public func makeUIView(context: Context) -> WKWebView {
        makeView(context: context)
    }
    
    public func updateUIView(_ view: WKWebView, context: Context) {
        
    }
    #endif
    
    #if os(macOS)
    public func makeNSView(context: Context) -> WKWebView {
        makeView(context: context)
    }
    
    public func updateNSView(_ view: WKWebView, context: Context) {
        
    }
    #endif
    
    private func makeView(context: Context) -> WKWebView {
        if let knownView = viewModel.webView {
            knownView.navigationDelegate = context.coordinator
            knownView.uiDelegate = context.coordinator
            return knownView
        }
        
        let wrappedView = WKWebView()
        
        wrappedView.isHidden = true
        wrappedView.scrollView.isScrollEnabled = false
        wrappedView.navigationDelegate = context.coordinator
        wrappedView.uiDelegate = context.coordinator
        
        if let url = Bundle.main.url(forResource: "index", withExtension: "html") {
            wrappedView.loadFileURL(url, allowingReadAccessTo: url)
        } else {
            wrappedView.loadHTMLString("console_failed".localized(), baseURL: nil)
        }
        
        viewModel.webView = wrappedView
        return wrappedView
    }

}

extension ConsoleView {
    
    public class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        let parent: ConsoleView
        var wrappedView: WKWebView!
        
        init(_ parent: ConsoleView) {
            self.parent = parent
        }
        
        func execute(_ source: String, completionHandler: @escaping () -> ()) {
            // Start loading
            parent.viewModel.showLoading = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                // Create JS script to execute in console
                // Put current script into console and press enter to execute
                let js = """
                var t = document.getElementById("userinput");
                t.value = `\(source.escapeCode())`;
                t.onkeydown({"keyCode": 13, "preventDefault": function (){}});
                """
                
                // Put source in top level
                self.wrappedView.evaluateJavaScript(js) { _, _ in
                    // Present output
                    DispatchQueue.main.async {
                        self.parent.viewModel.showLoading = false
                        completionHandler()
                    }
                }
            }
        }
        
        @objc func reloadConsole(_ sender: Any?) {
            // Reload console
            wrappedView.reloadFromOrigin()
        }
        
        public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            // Hide while it starts loading
            parent.viewModel.showLoading = true
            webView.isHidden = true
        }
        
        public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // Show console and stop loading
            webView.isHidden = false
            parent.viewModel.showLoading = false
        }
        
        public func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
            // Show a UIAlert controller
            let alert = UIAlertController(title: prompt, message: nil, preferredStyle: .alert)
            alert.addTextField { _ in }
            alert.addAction(UIAlertAction(title: "button_ok".localized(), style: .default, handler: { _ in
                completionHandler(alert.textFields?.first?.text)
            }))
            alert.addAction(UIAlertAction(title: "button_cancel".localized(), style: .cancel, handler: { _ in
                completionHandler(nil)
            }))
            //present(alert, animated: true, completion: nil)
        }
    }
}*/

struct ConsoleView: View {
    @ObservedObject var viewModel: ConsoleViewModel
    @State var currentLine: String = ""
    let id = UUID()
    
    var body: some View {
        if viewModel.showLoading {
            VStack(spacing: 16) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                Text("loading")
            }
        } else {
            ScrollView {
                ScrollViewReader { value in
                    VStack(alignment: .leading) {
                        Text(viewModel.output ?? "console_failed".localized())
                        HStack(alignment: .top) {
                            Text("#")
                            TextField("", text: $currentLine, onCommit: {
                                viewModel.execute(currentLine)
                                currentLine = ""
                            })
                                .autocapitalization(UITextAutocapitalizationType.none)
                                .disableAutocorrection(true)
                        }
                    }
                    .id(id)
                    .font( .system(size: 14, design: .monospaced))
                    .padding()
                    .fixedSize(horizontal: false, vertical: true)
                    .onChange(of: viewModel.output, perform: { _ in
                        value.scrollTo(id, anchor: .bottom)
                    })
                }
            }
        }
    }
}

struct ConsoleView_Previews: PreviewProvider {
    static var previews: some View {
        ConsoleView(viewModel: ConsoleViewModel())
    }
}
