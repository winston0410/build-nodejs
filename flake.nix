{
  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };

    npmlock2nix = {
      url = "github:tweag/npmlock2nix";
      flake = false;
    };
  };

  outputs = { nixpkgs, npmlock2nix, ... }:
    let system = "x86_64-linux";

    in {
      packages.${system} = let pkgs = nixpkgs.legacyPackages.${system};
      in {
        pug = (pkgs.callPackage ./pug.nix {
          npmlock2nix = (pkgs.callPackage npmlock2nix { });
        });
      };
    };
}

