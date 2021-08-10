package me.nathanfallet.ocaml.models

interface OCamlConsole {

    var output: ArrayList<ConsoleEntry>

    fun loadConsoleIfNeeded()
    fun reloadConsole()

    fun execute(source: String)

}

interface OCamlConsoleDelegate {

    fun didStartLoading()
    fun didFinishLoading()
    fun didExecute()
    fun didRefreshOutput()

}

class ConsoleEntry(span: String, content: String) {

    var span: String = span
    var content: String = content

}