{
  extras = hackage:
    { packages = ({} // { rin = ./rin.nix; }) // {}; };
  resolver = "lts-14.4";
  }