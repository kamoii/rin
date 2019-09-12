# rin

HTTP/HTTPS server for dev/debug. Will add feature as I need. For now it just prints Request headers.

## After changing project.yaml/stack.yaml

To update rin.cabal:

    stack build

Update nix files(pkgs.nix, rin.nix):

    stack-to-nix --output nix --stack-yaml stack.yaml

## Build static binary

Remove symbolick link `result` if there is any before bulding.

    nix build -f nix/release-static.nix
