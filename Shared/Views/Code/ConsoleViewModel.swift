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

import Foundation
import WebKit
import Combine
import StoreKit

class ConsoleViewModel: NSObject, ObservableObject, WKNavigationDelegate, WKUIDelegate {

    // The environment to execute OCaml code
    private lazy var webView: WKWebView = {
        let webView = WKWebView()

        webView.isHidden = true
        #if !os(macOS)
        webView.scrollView.isScrollEnabled = false
        #endif
        webView.navigationDelegate = self
        webView.uiDelegate = self

        if let url = Bundle.main.url(forResource: "index", withExtension: "html") {
            webView.loadFileURL(url, allowingReadAccessTo: url)
        } else {
            webView.loadHTMLString("console_failed".localized(), baseURL: nil)
        }

        return webView
    }()

    // State for the console
    @Published var showConsole: Bool = false
    @Published var showLoading: Bool = true {
        didSet {
            refreshOutput()
        }
    }

    // Content of the console
    @Published var output: String?

    // Any prompt
    @Published var prompt: String?
    var promptCompletionHandler: ((String?) -> Void)?

    // Load the console
    func loadConsoleIfNeeded() {
        _ = webView
    }

    // Refresh the output
    func refreshOutput() {
        webView.evaluateJavaScript("document.getElementById('output').textContent") { data, _ in
            self.output = (data as? String)?.trimEndlines()
        }
    }

    // Execute code
    func execute(_ source: String, completionHandler: @escaping () -> Void = {}) {
        // Start loading
        // showLoading = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // Create JS script to execute in console
            // Put current script into console and press enter to execute
            let js = """
            var t = document.getElementById("userinput");
            t.value = `\(source.escapeCode())`;
            t.onkeydown({"keyCode": 13, "preventDefault": function (){}});
            """

            // Put source in top level
            self.webView.evaluateJavaScript(js) { _, _ in
                // Present output
                DispatchQueue.main.async {
                    // self.showLoading = false
                    self.refreshOutput()
                    completionHandler()
                    self.checkForReview()
                }
            }
        }
    }

    // Reload console
    func reloadConsole(_ sender: Any?) {
        // Reload console
        webView.reloadFromOrigin()
    }

    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        // Hide while it starts loading
        showLoading = true
        webView.isHidden = true
    }

    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Show console and stop loading
        webView.isHidden = false
        showLoading = false
    }

    public func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        // Update prompt
        self.prompt = prompt
        self.promptCompletionHandler = completionHandler
    }

    // Check for review
    func checkForReview() {
        // Retrieve the number of save and increment it
        let datas = UserDefaults.standard
        let savesCount = datas.integer(forKey: "executeCount") + 1
        datas.set(savesCount, forKey: "executeCount")
        datas.synchronize()

        // Check number of saves to ask for a review
        if savesCount == 100 || savesCount == 500 || savesCount % 1000 == 0 {
            #if os(iOS)
            // Get main app scene
            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                // Request review
                SKStoreReviewController.requestReview(in: scene)
            }
            #else
            // Request review
            SKStoreReviewController.requestReview()
            #endif
        }
    }

}
