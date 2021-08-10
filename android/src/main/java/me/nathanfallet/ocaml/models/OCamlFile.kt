package me.nathanfallet.ocaml.models

import android.os.ParcelFileDescriptor
import java.io.*

class OCamlFile(source: String) {

    // File content
    var source: String = ""

    // Init a new file
    init {
        this.source = source
    }

    // Init an empty new file
    constructor() : this("")

    // Init a file from configuration
    constructor(inputStream: InputStream) : this() {
        // Read file content
        BufferedReader(InputStreamReader(inputStream)).use { reader ->
            this.source = reader.readText()
        }
    }

    // Save file
    fun saveFile(pfd: ParcelFileDescriptor) {
        // Save file content
        FileOutputStream(pfd.fileDescriptor).use {
            it.write(source.toByteArray())
        }
    }

}