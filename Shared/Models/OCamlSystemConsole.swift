/*
*  Copyright (C) 2023 Nathan Fallet
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

#if os(macOS)
import Foundation
import WebKit
import Combine

class OCamlSystemConsole: OCamlConsole {

    // The environment to execute OCaml code
    private var process: Process?
    private lazy var pipeIn = Pipe()
    private lazy var pipeOut: Pipe = createPipe(for: "caml")
    private lazy var pipeErr: Pipe = createPipe(for: "err")

    // Content of the console
    var output: [ConsoleEntry]?

    // Any prompt
    var prompt: String?
    var promptCompletionHandler: ((String?) -> Void)?

    // Delegate
    weak var delegate: OCamlConsoleDelegate?

    // Load the console
    func loadConsoleIfNeeded() {
        if process == nil {
            // Start loading
            delegate?.didStartLoading()
            process = Process()

            // Set ocaml executable
            process?.executableURL = URL(fileURLWithPath: "/bin/bash")
            process?.arguments = ["-c", "/usr/local/bin/ocaml"]

            // Setup pipes
            process?.standardInput = pipeIn
            process?.standardOutput = pipeOut
            process?.standardError = pipeErr

            // Launch task
            DispatchQueue.global(qos: .background).async {
                self.process?.launch()
            }
        }
    }

    // Execute code
    func execute(_ source: String) {
        // Send source code to process
        for line in source.split(separator: "\n") {
            // Add line on console as input
            self.appendOutput(str: String(line), span: "sharp")

            // Execute line
            if let data = line.data(using: .utf8) {
                self.pipeIn.fileHandleForWriting.write(data)
            }
            if let data = "\n".data(using: .utf8) {
                self.pipeIn.fileHandleForWriting.write(data)
            }
        }
        self.delegate?.didExecute()
    }

    // Reload console
    func reloadConsole() {
        // Reload console
        process?.terminate()
        process = nil
        loadConsoleIfNeeded()
    }

    // Create a pipe for a dedicated span
    func createPipe(for span: String) -> Pipe {
        let pipe = Pipe()

        pipe.fileHandleForReading.waitForDataInBackgroundAndNotify()
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name.NSFileHandleDataAvailable,
            object: pipe.fileHandleForReading,
            queue: nil
        ) { _ in
            self.appendOutput(
                str: String(data: pipe.fileHandleForReading.availableData, encoding: .utf8) ?? "",
                span: span
            )
            self.delegate?.didRefreshOutput()
            pipe.fileHandleForReading.waitForDataInBackgroundAndNotify()
        }

        return pipe
    }

    // Append output
    func appendOutput(str: String, span: String) {
        // Init if needed
        if output == nil {
            self.output = []
        }

        // Add content
        for sub in str.split(separator: "\n") {
            let entry = ConsoleEntry(
                id: output?.count ?? 0,
                span: span,
                content: String(sub)
            )
            output?.append(entry)
        }

        // Set console as loaded
        delegate?.didFinishLoading()
    }

}
#endif
