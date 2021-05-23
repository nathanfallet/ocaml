package me.nathanfallet.ocaml.activities

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import androidx.activity.result.contract.ActivityResultContracts
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import me.nathanfallet.ocaml.R
import me.nathanfallet.ocaml.fragments.CodeFragment
import me.nathanfallet.ocaml.models.OCamlFile
import me.nathanfallet.ocaml.viewmodels.CodeViewModel


class MainActivity : AppCompatActivity() {

    // Fragments
    private var codeFragment = CodeFragment()

    // View model
    private val codeViewModel: CodeViewModel by viewModels()

    // Register
    private val openResult = registerForActivityResult(ActivityResultContracts.StartActivityForResult()) { result ->
        result.data?.data?.also { uri ->
            load(uri)
        }
    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        val inflater = menuInflater
        inflater.inflate(R.menu.main_menu, menu)
        return super.onCreateOptionsMenu(menu)
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
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

                true
            }
            else -> super.onOptionsItemSelected(item)
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        supportFragmentManager.beginTransaction().add(R.id.codeFragment, codeFragment).commit()

        when(intent.action) {
            Intent.ACTION_VIEW, Intent.ACTION_EDIT  -> {
                intent.data?.let {
                    load(it)
                }
            }
        }
    }

    // Open a file
    private fun openFile() {
        val intent = Intent(Intent.ACTION_OPEN_DOCUMENT).apply {
            addCategory(Intent.CATEGORY_OPENABLE)
            type = "text/plain"
        }

        openResult.launch(intent)
    }

    // Create a new file
    private fun createFile() {
        val intent = Intent(Intent.ACTION_CREATE_DOCUMENT).apply {
            addCategory(Intent.CATEGORY_OPENABLE)
            type = "text/plain"
            putExtra(Intent.EXTRA_TITLE, "document.ml")
        }

        openResult.launch(intent)
    }

    // Load a document
    private fun load(uri: Uri) {
        // Save document Uri
        this.codeViewModel.uri(uri)

        // Load it in app
        val inputStream = applicationContext.contentResolver.openInputStream(uri) ?: return
        this.codeViewModel.file(OCamlFile(inputStream))
    }

    // Save a document
    private fun save(uri: Uri) {
        applicationContext.contentResolver.openFileDescriptor(uri, "w")?.use {
            this.codeViewModel.file.value?.saveFile(it)
        }
    }

}