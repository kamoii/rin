{ pkgs ? import <nixpkgs> {} }:

let
  pkgs64 = pkgs.pkgsCross.musl64;
  hsPkgs = import ./default.nix {
    pkgs = pkgs64;
    additional-modules = [
      { packages.rin.components.exes.rin.configureFlags = [
          "--disable-executable-dynamic"
          "--disable-shared"
          "--ghc-option=-optl=-pthread"
          "--ghc-option=-optl=-static"
          "--ghc-option=-optl=-L${pkgs64.gmp6.override { withStatic = true; }}/lib"
          "--ghc-option=-optl=-L${pkgs64.zlib.static}/lib"
          "--ghc-option=-optl=-L${pkgs64.libffi.overrideAttrs (old: { dontDisableStatic = true; })}/lib"
        ];
      }
    ];
  };
in
  hsPkgs.rin.components.exes.rin
