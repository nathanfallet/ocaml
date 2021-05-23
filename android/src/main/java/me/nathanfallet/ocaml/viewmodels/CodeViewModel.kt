package me.nathanfallet.ocaml.viewmodels

import android.net.Uri
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import me.nathanfallet.ocaml.models.OCamlFile

class CodeViewModel : ViewModel() {

    private val mutableFile = MutableLiveData<OCamlFile>()
    val file: LiveData<OCamlFile> get() = mutableFile

    private val mutableUri = MutableLiveData<Uri>()
    val uri: LiveData<Uri> get() = mutableUri

    fun file(file: OCamlFile) {
        mutableFile.value = file
    }

    fun uri(uri: Uri) {
        mutableUri.value = uri
    }

}