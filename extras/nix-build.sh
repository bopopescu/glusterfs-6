#!/bin/sh
nix-build -E \
"(import <nixpkgs> {
    config = import ./extras/glusterfs.nix {
      src = $PWD;
    };
  }
).glusterfsDev" $@
