{ pkgs, lib, stdenv, npmlock2nix, ... }:

# https://github.com/prettier/plugin-pug
let
  version = "743f5aafa11d161537bbcd614fe5af81944a8d2f";
  src = pkgs.fetchFromGitHub {
    owner = "winston0410";
    repo = "plugin-pug";
    rev = version;
    sha256 = "sha256-SUH94XnD0a0JX3SQQmHB9SWnS7oVP9BiBcS9a7o4wm0=";
  };
  nodeModules = npmlock2nix.node_modules {
    inherit src;
  };
in (stdenv.mkDerivation {
  pname = "prettier-plugin-pug";
  inherit version src;
  buildInputs = [ pkgs.nodejs ];
  buildPhase = ''
    echo ${nodeModules}
  '';
  postBuild = ''
    echo $out
  '';
  installPhase = ''
    echo "hello" > $out
  '';
})
