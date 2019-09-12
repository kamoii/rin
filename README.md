# rin

## After changing project.yaml/stack.yaml

To update rin.cabal:

    stack build

Update nix files(pkgs.nix, rin.nix):

    stack-to-nix --output nix --stack-yaml stack.yaml

## Build static binary

    nix build -f nix/release-static.nix
