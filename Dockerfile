FROM mattam82/coq:8.14.1-ocaml-4.12-1--clang-11-compcert-3.9--extlib-0.11.6--equations-1.3

RUN sudo apt update && sudo apt upgrade --yes

RUN sudo apt install --yes wabt nodejs wget

RUN opam update

RUN git clone https://github.com/womeier/certicoqwasm repo && cd repo && git submodule update --init

RUN cd repo && opam pin -n -y submodules/metacoq # same path to pinned subrepo as in GH pin command -> opam knows it didn't change -> don't rebuild

RUN cd repo && opam pin -n -y .

RUN cd repo && opam install coq-certicoq --deps-only --yes

RUN rm -rf repo


# TODO: fewer layers, install mathcomp-ssreflect 1.16.0
