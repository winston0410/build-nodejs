{ pkgs, lib, stdenv, ... }:

{
  mkNpmModules = { pname, version, src, lockFile }:
    let cwd = pkgs.fetchFromGitHub src;
    in (pkgs.stdenv.mkDerivation {
      inherit pname version;

      src = cwd;

      buildInputs = with pkgs; [ nodejs nodePackages.node2nix git ];

      buildPhase = let
        nodeDependencies = pkgs.runCommand "node.nix" { } ''
          ${pkgs.nodePackages.node2nix}/bin/node2nix -l ${cwd + lockFile}
        '';
      in ''
        ls -a ${nodeDependencies}
      '';
    });
}
