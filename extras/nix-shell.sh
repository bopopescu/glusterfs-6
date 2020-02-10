#!/bin/sh
nix-shell -E \
"(import <nixpkgs> {
    config = import ./extras/glusterfs.nix {
      src = $PWD;
    };
  }
).glusterfsDev" $@
