package me.nathanfallet.ocaml.viewmodels

import android.app.Application
import android.content.Context
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import me.nathanfallet.ocaml.extensions.DigiAnalyticsExtension
import me.nathanfallet.ocaml.models.*

class ConsoleViewModel(application: Application): AndroidViewModel(application), OCamlConsoleDelegate {

    // The environment to execute OCaml code
    private val console: OCamlConsole

    // Initializer
    init {
        // Generate console
        this.console = OCamlWebConsole(getApplication())
        console.delegate = this
    }

    // State for the console
    private val showConsole = MutableLiveData<Boolean>()
    private val showLoading = MutableLiveData<Boolean>()
    private val showExecuting = MutableLiveData<Boolean>()
    private val output = MutableLiveData<ArrayList<ConsoleEntry>>()

    fun isConsoleShown(): LiveData<Boolean> {
        return showConsole
    }

    fun isLoadingShown(): LiveData<Boolean> {
        return showLoading
    }

    fun isExecutingShown(): LiveData<Boolean> {
        return showExecuting
    }

    fun getOutput(): LiveData<ArrayList<ConsoleEntry>> {
        return output
    }

    // Load the console
    fun loadConsoleIfNeeded() {
        console.loadConsoleIfNeeded()
    }

    // Refresh the output
    fun refreshOutput() {
        output.value = console.output
    }

    // Execute code
    fun execute(source: String) {
        // Start loading
        showExecuting.value = true

        // Check to execute on another thread?
        // Send to console
        console.execute(source/*.removeComments()*/)
    }

    // Reload console
    fun reloadConsole() {
        console.reloadConsole()
    }

    override fun didStartLoading() {
        showLoading.value = true
    }

    override fun didFinishLoading() {
        showLoading.value = false
    }

    override fun didExecute() {
        // Go to main thread?
        refreshOutput()
        showExecuting.value = false
        executed()
    }

    override fun didRefreshOutput() {
        // Go to main thread?
        refreshOutput()
    }

    // Run after execution
    private fun executed() {
        // Analytics
        DigiAnalyticsExtension.shared.send("execute", getApplication())

        // Ask for a review
        // TODO
    }

}