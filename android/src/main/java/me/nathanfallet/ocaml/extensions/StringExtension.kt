package me.nathanfallet.ocaml.extensions

import me.nathanfallet.ocaml.models.ConsoleEntry

// Code escape

fun String.escapeCode(): String {
    return replace("\\", "\\\\")
        .replace("`", "\\`")
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
    val str = this
        .removePrefix("\"")
        .removeSuffix("\"")
        .replace("\\\"", "\"")
        .replace("\\\n", "\n")
        .replace("\\u003C", "<")
    val results = Regex(
        """<span class="([a-z]+)">([^<>]+)</span>""",
        setOf(RegexOption.DOT_MATCHES_ALL, RegexOption.MULTILINE)
    ).findAll(str)

    for (el in results) {
        val content = el.groupValues[2].trimEndlines().replaceHTMLChars()
        if (content.isNotEmpty()) {
            spans.add(ConsoleEntry(el.groupValues[1], content))
        }
    }

    return spans
}