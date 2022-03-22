package me.nathanfallet.ocaml.activities

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.preference.PreferenceManager
import android.provider.OpenableColumns
import android.view.Menu
import android.view.MenuItem
import android.widget.FrameLayout
import androidx.activity.result.contract.ActivityResultContracts
import androidx.activity.viewModels
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import me.nathanfallet.ocaml.R
import me.nathanfallet.ocaml.extensions.DigiAnalyticsExtension
import me.nathanfallet.ocaml.fragments.CodeFragment
import me.nathanfallet.ocaml.fragments.ConsoleFragment
import me.nathanfallet.ocaml.models.OCamlFile
import me.nathanfallet.ocaml.viewmodels.CodeViewModel
import me.nathanfallet.ocaml.viewmodels.ConsoleViewModel


class MainActivity : AppCompatActivity() {

    // Fragments
    private var codeFragment = CodeFragment()
    private var consoleFragment = ConsoleFragment()
    private var showConsole = false

    // View models
    private val codeViewModel: CodeViewModel by viewModels()
    private val consoleViewModel: ConsoleViewModel by viewModels()

    // Register
    private val openResult = registerForActivityResult(ActivityResultContracts.StartActivityForResult()) { result ->
        result.data?.data?.also { uri ->
            load(uri)
        }
    }
    private val saveResult = registerForActivityResult(ActivityResultContracts.StartActivityForResult()) { result ->
        result.data?.data?.also { uri ->
            save(uri)
            load(uri)
        }
    }

    override fun onCreateOptionsMenu(menu: Menu): Boolean {
        val inflater = menuInflater
        inflater.inflate(R.menu.main_menu, menu)
        return super.onCreateOptionsMenu(menu)
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        // Close console if shown
        if (showConsole) {
            showConsole = false
            supportFragmentManager.popBackStack()
        }
        return when (item.itemId) {
            R.id.open -> {
                openFile()
                true
            }
            R.id.save -> {
                codeViewModel.uri.value?.let {
                    save(it)
                } ?: run {
                    createFile()
                }
                true
            }
            R.id.play -> {
                showConsole()
                codeViewModel.file.value?.source?.let {
                    consoleViewModel.execute(it)
                }
                true
            }
            else -> super.onOptionsItemSelected(item)
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // Set fragments
        supportFragmentManager.beginTransaction().add(R.id.codeFragment, codeFragment).commit()

        // Check if console is visible to set it
        // Note: Don't know what happens when a tablet rotates and console should be either shown or hidden
        if (findViewById<FrameLayout>(R.id.consoleFragment) != null) {
            supportFragmentManager.beginTransaction().add(R.id.consoleFragment, consoleFragment).commit()
        }

        // Handle file opening
        when(intent.action) {
            Intent.ACTION_VIEW, Intent.ACTION_EDIT  -> {
                // Load file
                intent.data?.let {
                    load(it)
                }
            }
            else -> {
                // Start with a new file
                codeViewModel.file(OCamlFile())
            }
        }

        // Load console if needed
        initializeAnalytics()
        consoleViewModel.loadConsoleIfNeeded()
    }

    private fun initializeAnalytics() {
        // Send first open
        val data = PreferenceManager.getDefaultSharedPreferences(this)
        if (!data.getBoolean("first_open", false)) {
            DigiAnalyticsExtension.shared.send("first_open", this)
            data.edit().putBoolean("first_open", true).apply()
        }

        // Send open
        DigiAnalyticsExtension.shared.send("file", this)
    }

    // Open a file
    private fun openFile() {
        val intent = Intent(Intent.ACTION_OPEN_DOCUMENT).apply {
            addCategory(Intent.CATEGORY_OPENABLE)
            type = "*/*"
        }

        openResult.launch(intent)
    }

    // Create a new file
    private fun createFile() {
        val intent = Intent(Intent.ACTION_CREATE_DOCUMENT).apply {
            addCategory(Intent.CATEGORY_OPENABLE)
            type = "*/*"
            putExtra(Intent.EXTRA_TITLE, "document.ml")
        }

        saveResult.launch(intent)
    }

    // Handle URI
    private fun handleURI(uri: Uri): Boolean {
        // First check that file is a supported .ml or .mli file
        val name = queryFileName(uri)
        if (
            !name.orEmpty().endsWith(".ml") &&
            !name.orEmpty().endsWith(".mli")
        ) {
            // File type is not supported
            AlertDialog.Builder(this)
                .setTitle(R.string.extension_not_supported_title)
                .setMessage(R.string.extension_not_supported_message)
                .setNeutralButton(R.string.button_ok, null)
                .show()
            return false
        }

        // Save document Uri
        this.codeViewModel.uri(uri)

        return true
    }

    // Load a document
    private fun load(uri: Uri) {
        if (handleURI(uri)) {
            // Load it in app
            val inputStream = contentResolver.openInputStream(uri) ?: return
            this.codeViewModel.file(OCamlFile(inputStream))
        }
    }

    // Save a document
    private fun save(uri: Uri) {
        if (handleURI(uri)) {
            contentResolver.openFileDescriptor(uri, "w")?.use {
                this.codeViewModel.file.value?.saveFile(it)
            }
        }
    }

    // Get file name
    private fun queryFileName(uri: Uri): String? {
        val cursor = contentResolver.query(uri, null, null, null, null) ?: return null
        val nameIndex: Int = cursor.getColumnIndex(OpenableColumns.DISPLAY_NAME)
        cursor.moveToFirst()
        val name: String = cursor.getString(nameIndex)
        cursor.close()
        return name
    }

    // Show console
    private fun showConsole() {
        // If console is not visible (on phones or little screens)
        if (findViewById<FrameLayout>(R.id.consoleFragment) == null && !showConsole) {
            showConsole = true
            supportFragmentManager.beginTransaction().replace(R.id.codeFragment, consoleFragment).addToBackStack(null).commit();
        }
    }

    override fun onBackPressed() {
        if (supportFragmentManager.backStackEntryCount > 0) {
            if (showConsole) {
                showConsole = false
            }
            supportFragmentManager.popBackStack()
        } else {
            super.onBackPressed()
        }
    }


}