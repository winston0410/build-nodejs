{ pkgs, lib, stdenv, ... }:

# https://github.com/prettier/plugin-pug
let 
  version = "1.16.7";
  yarn2nix = pkgs.haskellPackages.yarn2nix;
in (stdenv.mkDerivation {
  pname = "prettier-plugin-pug";
  inherit version;
  buildInputs = [ pkgs.nodejs pkgs.git yarn2nix ];
  src = pkgs.fetchFromGitHub {
    owner = "prettier";
    repo = "plugin-pug";
    rev = version;
    sha256 = "3sETKw+Vv+SgxyRUEbweD3s24zz9M+UpD6LaSsAIYlk=";
  };
  buildPhase = ''
      ${yarn2nix}/bin/yarn2nix --help
      echo ${yarn2nix}
  '';
})

# mkNpmModules = (pkgs.callPackage ./mkNpmModules.nix { }).mkNpmModules;

# Doesn't work as this project uses yarn
# let
# version = "1.16.7";
# source = pkgs.fetchFromGitHub {
# owner = "prettier";
# repo = "plugin-pug";
# rev = version;
# sha256 = "3sETKw+Vv+SgxyRUEbweD3s24zz9M+UpD6LaSsAIYlk=";
# };
# in (npmlock2nix.build {
# pname = "prettier-plugin-pug";
# inherit version;
# buildInputs = with pkgs; [ nodejs git ];
# src = source;
# node_modules_attrs = {
# packageLockJson = "${source + "/yarn.lock"}";
# };
# buildCommands = [ "npm run build" ];
# installPhase = "cp -r dist $out";
# })

# let 
# version = "1.16.7";
# in (pkgs.stdenv.mkDerivation {
# pname = "prettier-plugin-pug";
# inherit version;
# buildInputs = with pkgs; [ nodejs git ];
# src = pkgs.fetchFromGitHub{
# owner = "prettier";
# repo = "plugin-pug";
# rev = version;
# sha256 = "3sETKw+Vv+SgxyRUEbweD3s24zz9M+UpD6LaSsAIYlk=";
# };
# buildPhase = ''
# echo ${npmlock2nix}
# '';
# })
