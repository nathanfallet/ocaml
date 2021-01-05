// Installs globals. I couldn't figure out how to stop it doing that.
import "../static/bsReasonReact";
const bsReasonReact = {
  reason: global.reason,
  ocaml: global.ocaml,
};

import reason from "reason";
import stripAnsi from "strip-ansi";
import { levels, create as createConsole } from "./console";

export const translate = (source, target, code) => {
  try {
    const ast = source !== "ml" ? reason.parseRE(code) : reason.parseML(code);
    const out = target !== "ml" ? reason.printRE(ast) : reason.printML(ast);
    return [null, out];
  } catch {
    return [e.message || "Unknown error", null];
  }
};

const startPadding = /^ {2}/gm;
const noFileName = /\(No file name\)/gm;
const defaultConsole = global.console;
export const compile = (language, code) => {
  try {
    const { console, messages } = createConsole();
    global.console = console;
    const { js_code: out } =
      language !== "ml"
        ? bsReasonReact.reason.compile_super_errors_ppx_v2(code)
        : bsReasonReact.ocaml.compile_super_errors_ppx_v2(code);

    // See https://github.com/reasonml/reasonml.github.io/blob/source/website/playground/try.js
    const errors = messages
      .filter((x) => x.level === levels.ERROR)
      .map((x) => {
        const message = x.parts.map((x) => x.label.description).join(" ");
        return stripAnsi(message);
      })
      // this is a warning we get:
      // WARN: File "js_cmj_load.ml", line 53, characters 23-30 ReactDOMRe.cmj not found
      // TODO: not sure why; investigate into it
      .filter((x) => x.indexOf('WARN: File "js_cmj_load.ml"') === -1)
      .join("\n")
      .replace(startPadding, "")
      .replace(noFileName, "Preview")
      .trim();

    return errors.length === 0 ? [null, out] : [errors, null];
  } catch (e) {
    return [e.message || "Unknown error", null];
  } finally {
    global.console = defaultConsole;
  }
};

const requireLibFile = (file) => require(`../bs/${file.replace(/^\.\//, "")}`);
export const evalScript = (code) => {
  const { messages, console } = createConsole();

  try {
    const fn = new Function("require", "exports", "console", code);
    fn(requireLibFile, {}, console);
  } catch (e) {
    console.error(e.message || "Unknown error");
  }

  return messages;
};
