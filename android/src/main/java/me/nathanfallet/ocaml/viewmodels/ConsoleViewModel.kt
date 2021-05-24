package me.nathanfallet.ocaml.viewmodels

import android.content.Context
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import me.nathanfallet.ocaml.models.*

class ConsoleViewModel(context: Context): ViewModel(), OCamlConsoleDelegate {

    // The environment to execute OCaml code
    private val console: OCamlConsole

    // Initializer
    init {
        // Generate console
        this.console = OCamlWebConsole(context)
        console.delegate = this
    }

    // State for the console
    private val mutableShowConsole = MutableLiveData<Boolean>()
    val showConsole: LiveData<Boolean> get() = mutableShowConsole

    private val mutableShowLoading = MutableLiveData<Boolean>()
    val showLoading: LiveData<Boolean> get() = mutableShowLoading

    private val mutableShowExecuting = MutableLiveData<Boolean>()
    val showExecuting: LiveData<Boolean> get() = mutableShowExecuting

    fun showConsole(showConsole: Boolean) {
        mutableShowConsole.value = showConsole
    }
    fun showLoading(showLoading: Boolean) {
        mutableShowLoading.value = showLoading
    }
    fun showExecuting(showExecuting: Boolean) {
        mutableShowExecuting.value = showExecuting
    }

    // Content of the console
    private val mutableOutput = MutableLiveData<ArrayList<ConsoleEntry>>()
    val output: LiveData<ArrayList<ConsoleEntry>> get() = mutableOutput

    fun output(output: ArrayList<ConsoleEntry>) {
        mutableOutput.value = output
    }

    // Load the console
    fun loadConsoleIfNeeded() {
        console.loadConsoleIfNeeded()
    }

    // Refresh the output
    fun refreshOutput() {
        output(console.output)
    }

    // Execute code
    fun execute(source: String) {
        // Start loading
        showExecuting(true)

        // Check to execute on another thread?
        // Send to console
        console.execute(source/*.removeComments()*/)
    }

    // Reload console
    fun reloadConsole() {
        console.reloadConsole()
    }

    override fun didStartLoading() {
        showLoading(true)
    }

    override fun didFinishLoading() {
        showLoading(false)
    }

    override fun didExecute() {
        // Go to main thread?
        refreshOutput()
        showExecuting(false)
        executed()
    }

    override fun didRefreshOutput() {
        // Go to main thread?
        refreshOutput()
    }

    // Run after execution
    fun executed() {
        // Analytics

        // Ask for a review

    }

}