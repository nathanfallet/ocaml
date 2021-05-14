# First, install OCaml and OPAM
brew install ocaml
brew install opam

# Init OPAM
opam init
opam update
eval $(opam env)

# Then, install Js_of_ocaml and its dependencies
opam install Js_of_ocaml-toplevel

# Build the toplevel
git clone https://github.com/ocsigen/js_of_ocaml
cd js_of_ocaml/toplevel/examples/lwt_toplevel/
dune build

# Go back to root folder
cd ../../../../
cp js_of_ocaml/_build/default/toplevel/examples/lwt_toplevel/toplevel.js Shared/JavaScript/
