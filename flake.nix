{
  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    npmlock2nix = {
      # url = "path:/home/hugosum/npmlock2nix";
      url = "github:nix-community/npmlock2nix";
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
        
        test = (pkgs.callPackage ./test.nix {
          npmlock2nix = (pkgs.callPackage npmlock2nix { });
        });
      };
      devShell.${system} = (({ pkgs, ... }:
        pkgs.mkShell {
          buildInputs = [ ];

          shellHook = ''
            nix flake lock --update-input npmlock2nix;
          '';
        }) { pkgs = nixpkgs.legacyPackages.${system}; });
    };
}

