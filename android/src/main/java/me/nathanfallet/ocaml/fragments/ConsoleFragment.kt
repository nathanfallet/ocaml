package me.nathanfallet.ocaml.fragments

import android.annotation.SuppressLint
import android.content.Context
import android.graphics.Typeface
import android.os.Build
import android.os.Bundle
import android.util.TypedValue
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.inputmethod.EditorInfo
import android.widget.EditText
import android.widget.TextView
import androidx.core.content.ContextCompat
import androidx.fragment.app.activityViewModels
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import me.nathanfallet.ocaml.R
import me.nathanfallet.ocaml.viewmodels.ConsoleViewModel

class ConsoleFragment : Fragment() {

    private val consoleAdapter = ConsoleAdapter()
    private val consoleViewModel: ConsoleViewModel by activityViewModels()

    @SuppressLint("NotifyDataSetChanged")
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Create the view
        val rootView = inflater.inflate(R.layout.fragment_console, container, false)

        // Configure recycler view
        val recyclerView = rootView.findViewById<RecyclerView>(R.id.recyclerView)
        recyclerView.layoutManager = LinearLayoutManager(rootView.context)
        recyclerView.setHasFixedSize(true)
        recyclerView.adapter = consoleAdapter

        // Configure field
        val field = rootView.findViewById<EditText>(R.id.field)
        field.setOnEditorActionListener { _, actionId, _ ->
            var handled = false
            if (actionId == EditorInfo.IME_ACTION_SEND) {
                consoleViewModel.execute(field.text.toString())
                field.setText("")
                handled = true
            }
            handled
        }

        // Listen for changes
        consoleViewModel.getOutput().observe(viewLifecycleOwner) {
            consoleAdapter.notifyDataSetChanged()
        }

        // Return the view
        return rootView
    }

    inner class ConsoleAdapter: RecyclerView.Adapter<ConsoleAdapter.ConsoleViewHolder>() {

        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ConsoleViewHolder {
            // Create a new view
            val textView = TextView(parent.context)
            textView.typeface = Typeface.MONOSPACE
            return ConsoleViewHolder(textView)
        }

        override fun onBindViewHolder(holder: ConsoleViewHolder, position: Int) {
            // Set view content
            consoleViewModel.getOutput().value?.get(position)?.let {
                when (it.span) {
                    "sharp" -> {
                        holder.textView.text = "# %s".format(it.content)
                        holder.textView.setTextColor(getColorAttr(android.R.attr.textColorPrimary,
                            holder.textView.context))
                    }
                    "caml" -> {
                        holder.textView.text = it.content
                        holder.textView.setTextColor(getColor(android.R.color.holo_blue_light,
                            holder.textView.context))
                    }
                    "stderr" -> {
                        holder.textView.text = it.content
                        holder.textView.setTextColor(getColor(android.R.color.holo_red_light,
                            holder.textView.context))
                    }
                    else -> {
                        holder.textView.text = it.content
                        holder.textView.setTextColor(getColorAttr(android.R.attr.textColorPrimary,
                            holder.textView.context))
                    }
                }
            }
            // Also need to set color based on span
        }

        override fun getItemCount(): Int {
            // Number of lines
            return consoleViewModel.getOutput().value?.size ?: 0
        }

        private fun getColor(id: Int, context: Context): Int {
            return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                resources.getColor(id, context.theme)
            } else {
                resources.getColor(id)
            }
        }

        private fun getColorAttr(id: Int, context: Context): Int {
            val resolvedAttr = TypedValue()
            context.theme.resolveAttribute(id, resolvedAttr, true)
            val colorRes = resolvedAttr.run { if (resourceId != 0) resourceId else data }
            return ContextCompat.getColor(context, colorRes)
        }

        inner class ConsoleViewHolder(itemView: TextView) : RecyclerView.ViewHolder(itemView) {
            val textView: TextView = itemView
        }

    }

}