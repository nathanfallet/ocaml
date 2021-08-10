package me.nathanfallet.ocaml.models

import android.annotation.SuppressLint
import android.content.Context
import android.webkit.WebView
import me.nathanfallet.ocaml.extensions.escapeCode
import me.nathanfallet.ocaml.extensions.splitInSpans

class OCamlWebConsole(
    private val context: Context
): OCamlConsole {

    // The environment to execute OCaml code
    private val webView: WebView by lazy {
        generateWebView()
    }

    // Web view generator
    @SuppressLint("SetJavaScriptEnabled")
    private fun generateWebView(): WebView {
        val webView = WebView(context)

        webView.settings.javaScriptEnabled = true
        webView.settings.domStorageEnabled = true
        webView.loadUrl("file:///android_asset/index.html")

        return webView
    }

    // Content of the console
    override var output = ArrayList<ConsoleEntry>()

    // Any prompt
    // for later

    // Delegate
    var delegate: OCamlConsoleDelegate? = null

    // Load the console
    override fun loadConsoleIfNeeded() {
        webView
    }

    // Refresh the output
    fun refreshOutput() {
        webView.evaluateJavascript("document.getElementById('output').innerHTML") {
            this.output = it.splitInSpans()
            this.delegate?.didFinishLoading()
            this.delegate?.didExecute()
        }
    }

    // Execute code
    override fun execute(source: String) {
        // Create JS script to execute in console
        // Put current script into console and press enter to execute
        val escaped = source.escapeCode()
        val js = """
        var t = document.getElementById("userinput");
        t.value = `$escaped`;
        t.onkeydown({"keyCode": 13, "preventDefault": function (){}});
        """

        // Put source in top level
        webView.evaluateJavascript(js) {
            // Present output
            this.refreshOutput()
        }
    }

    // Refresh the output
    override fun reloadConsole() {
        webView.reload()
    }


}
