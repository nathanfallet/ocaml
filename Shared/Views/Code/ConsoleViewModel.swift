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
import DigiAnalytics

class ConsoleViewModel: NSObject, ObservableObject, OCamlConsoleDelegate {

    // The environment to execute OCaml code
    private lazy var console: OCamlConsole = {
        #if os(macOS)
        // Check if OCaml is installated on the system
        // For now we default on web console because system one is not ready
        let console = OCamlWebConsole()
        #else
        // On iOS, only web console is supported
        let console = OCamlWebConsole()
        #endif

        // Set delegate and return the console
        console.delegate = self
        return console
    }()

    // State for the console
    @Published var showConsole: Bool = false
    @Published var showLoading: Bool = true {
        didSet {
            refreshOutput()
        }
    }
    @Published var showExecuting: Bool = false

    // Content of the console
    @Published var output: [ConsoleEntry]?

    // Any prompt
    @Published var prompt: String?
    var promptCompletionHandler: ((String?) -> Void)?

    // Load the console
    func loadConsoleIfNeeded() {
        console.loadConsoleIfNeeded()
    }

    // Refresh the output
    func refreshOutput() {
        output = console.output
    }

    // Execute code
    func execute(_ source: String) {
        // Start loading
        showExecuting = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // Send to the console
            self.console.execute(source/*.removeComments()*/)
        }
    }

    // Reload console
    func reloadConsole() {
        // Reload console
        console.reloadConsole()
    }

    func didStartLoading() {
        self.showLoading = true
    }

    func didFinishLoading() {
        self.showLoading = false
    }

    func didExecute() {
        DispatchQueue.main.async {
            self.refreshOutput()
            self.showExecuting = false
            self.executed()
        }
    }

    func didRefreshOutput() {
        DispatchQueue.main.async {
            self.refreshOutput()
        }
    }

    // Run after execution
    func executed() {
        // Analytics
        DigiAnalytics.shared.send(path: "execute")

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
