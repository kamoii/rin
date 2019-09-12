# rin

HTTP server for dev/debug. Will add feature as I need. For now it just prints Request headers.

## Build static binary

First update nix files(pkgs.nix, rin.nix):

    stack-to-nix --output nix --stack-yaml stack.yaml

Then build with nix. Remove symbolick link `result` if there is any before bulding.

    nix build -f nix/release-static.nix
