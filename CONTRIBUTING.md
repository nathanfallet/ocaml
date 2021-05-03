# Contribute to the app

Thanks for having an interest in our app. If you want to help us to make it better, you are at the right place!

## Report a bug

To report a bug, open an Issue. Explain what happened, what you expected to happen, and give steps to reproduce the bug.

## Suggest a feature

To suggest a feature, also open an Issue, and describe the feature of you dream.

## Suggest a chapter for the learn section

You can:

* Open an issue in which you expose the content of you chapter. Someone will add it to the codebase for you.
* Edit the codebase by yourself. (See the `docs/` folder in the File organization section for details)

## Help to translate

To help to translate the app in new languages, join the [weblate](https://weblate.groupe-minaste.org/projects/ocaml/) of our organization. Feel free to open an Issue to ask for a new language if the one you are looking for is not available for translation on weblate.

## Contribute to the source code

To contribute to the source code, fork this repository, make your changes, and open a Pull Request.

If your are making your first contribution, please read what follows to understand the structure of the project first.

### File organization (in `Shared/`)

Files are separated in 4 folders:

#### `Extensions/` folder

Those files are existing Swift classes' extensions, and provide useful feature across all the codebase.

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

#### `Views/` folder

In this folder are located all the views of the app.
