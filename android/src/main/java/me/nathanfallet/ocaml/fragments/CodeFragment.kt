package me.nathanfallet.ocaml.fragments

import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.activityViewModels
import de.markusressel.kodeeditor.library.view.CodeEditorLayout
import me.nathanfallet.ocaml.viewmodels.CodeViewModel

class CodeFragment : Fragment(), TextWatcher {

    private val codeViewModel: CodeViewModel by activityViewModels()
    private var editor: CodeEditorLayout? = null

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Create and configure editor
        editor = context?.let {
            CodeEditorLayout(it)
        }

        editor?.codeEditorView?.codeEditText?.addTextChangedListener(this)

        return editor
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        codeViewModel.file.observe(viewLifecycleOwner) { file ->
            editor?.let {
                if (it.text != file.source) {
                    it.text = file.source
                }
            }
        }
    }

    override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {
        // Nothing here
    }

    override fun onTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {
        // Update text back to file
        editor?.text?.let {
            codeViewModel.file.value?.source = it
        }
    }

    override fun afterTextChanged(p0: Editable?) {
        // Nothing here
    }

}