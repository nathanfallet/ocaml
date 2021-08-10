# First, install OCaml and OPAM
brew install xquartz
brew install xorgproto
brew install ocaml
brew install opam

# Init OPAM
opam init -y
opam update
eval $(opam env)

# Then, install Js_of_ocaml and its dependencies
opam install -y Js_of_ocaml-toplevel
opam install -y lwt graphics react reactiveData ocp-indent tyxml lwt_log #higlo

# Build the toplevel
git clone https://github.com/ocsigen/js_of_ocaml
cd js_of_ocaml/toplevel/examples/lwt_toplevel/
dune external-lib-deps --missing @@default
dune build

# Go back to root folder
cd ../../../../
cp js_of_ocaml/_build/default/toplevel/examples/lwt_toplevel/toplevel.js Shared/JavaScript/
cp js_of_ocaml/_build/default/toplevel/examples/lwt_toplevel/toplevel.js android/src/main/assets/
