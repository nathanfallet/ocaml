package me.nathanfallet.ocaml.extensions

import android.util.JsonReader
import android.util.JsonToken
import me.nathanfallet.ocaml.models.ConsoleEntry
import java.io.IOException
import java.io.StringReader

// Code escape

fun String.escapeCode(): String {
    return replace("\\", "\\\\")
        .replace("`", "\\`")
}

fun String.decodeJSON(): String {
    var str = this
    val json = JsonReader(StringReader(this))
    json.isLenient = true
    try {
        if (json.peek() == JsonToken.STRING) {
            str = json.nextString()
        }
    } catch (e: IOException) {
        e.printStackTrace()
    } finally {
        json.close()
    }
    return str
}

fun String.trimEndlines(): String {
    while (startsWith("\n")) run {
        removePrefix("\n")
    }
    while (endsWith("\n")) run {
        removeSuffix("\n")
    }
    return this
}

fun String.replaceHTMLChars(): String {
    return replace("&lt;", "<")
        .replace("&gt;", ">")
        .replace("&amp;", "&")
}

// Regex

fun String.splitInSpans(): ArrayList<ConsoleEntry> {
    val spans = ArrayList<ConsoleEntry>()
    val results = Regex(
        """<span class="([a-z]+)">([^<>]+)</span>""",
        setOf(RegexOption.DOT_MATCHES_ALL, RegexOption.MULTILINE)
    ).findAll(decodeJSON().replace("\n", ""))

    for (el in results) {
        val content = el.groupValues[2].trimEndlines().replaceHTMLChars()
        if (content.isNotEmpty()) {
            spans.add(ConsoleEntry(el.groupValues[1], content))
        }
    }

    return spans
}