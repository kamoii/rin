{ pkgs ? import <nixpkgs> {} }:

let
  hsPkgs = import ./default.nix {
    pkgs = pkgs.pkgsCross.musl64;
    additional-modules = [
      { packages.rin.components.exes.rin.configureFlags = [
          "--disable-executable-dynamic"
          "--disable-shared"
          "--ghc-option=-optl=-pthread"
          "--ghc-option=-optl=-static"
          "--ghc-option=-optl=-L${pkgs.gmp6.override { withStatic = true; }}/lib"
          "--ghc-option=-optl=-L${pkgs.zlib.static}/lib"
          "--ghc-option=-optl=-L${pkgs.libffi.overrideAttrs (old: { dontDisableStatic = true; })}/lib"
        ];
      }
    ];
  };
in
  hsPkgs.rin.components.exes.rin
