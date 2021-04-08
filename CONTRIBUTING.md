# Contribute to the app

Thanks for having an interest in our app. If you want to help us to make it better, you are at the right place!

## Report a bug

To report a bug, open an Issue. Explain what happened, what you expected to happen, and give steps to reproduce the bug.

## Suggest a feature

To suggest a feature, also open an Issue, and describe the feature of you dream.

## Suggest a chapter for the learn section

You can:

* Open an issue in which you expose the content of you chapter. Someone will add it to the codebase for you.
* Edit the codebase by yourself. (See the `Models/` folder in the File organization section for details)

## Help to translate

To help to translate the app in new languages, join the [weblate](https://weblate.groupe-minaste.org/projects/ocaml/) of our organization. Feel free to open an Issue to ask for a new language if the one you are looking for is not available for translation on weblate.

## Contribute to the source code

To contribute to the source code, fork this repository, make your changes, and open a Pull Request.

If your are making your first contribution, please read what follows to understand the structure of the project first.

### File organization (in `OCaml/`)

Files are separated in 5 folders:

#### `Controllers/` folder

Those files are application's view controllers. The root view controller is `TabBarController`, which contains 3 tabs, handled by:

* `LearnSplitViewController`, the parent of `LearnTableViewController`, the list of available content in learn section, and `LearnChapterViewController`, which displays a chapter.
* `CodeSplitViewController`, the parent of `CodeViewController`, the code editor itself, and `ConsoleViewController`, the interactive top level where code is executed.
* `SettingsTableViewController`, a table view with settings to customize the app.

#### `Extensions/` folder

Those files are existing Swift classes' extensions, and provide useful feature across all the codebase.

* `IntExtension.swift` provides a way to convert Int to UIColor.
* `UIColorExtension.swift` does the same but for UIColor to Int.
* `StringExtension.swift` provides a way to localize String and format them.

Note about String localization: When adding a new String, its identifier should be added to `en.lproj/Localizable.strings`, and then it is used in the codebase like this:

```
"example" = "Some example string";
```
```swift
"example".localized() // Returns "Some example string", or its translation depending on user language
```

#### `JavaScript/` folder

This folder contains the toplevel itself, built with `js_of_ocaml`. Changes in this folder are not frequent.

#### `Models/` folder

Here are some models for the app to work.

* `CustomTheme` and `OCamlLexer` are dedicated to the code editor, providing code highlight.
* `LearnModel` provides the structures for the course content.
* `OCamlCourse.swift` is the registry for the content of the Learn section.

Consequence: If you want to add a chapter to the learn section, edit the `OCamlCourse.swift` file. (Don't forget to add your strings to the `en.lproj/Localizable.strings` file)

#### `Views/` folder

In this folder are located views like table view cells or other custom UIViews.
