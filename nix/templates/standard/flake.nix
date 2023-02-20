{
  description = "A standard flake template";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils, ... }@inputs:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          config.allowUnfree = true;
          inherit system;
        };
      in rec {
        devShells.default = pkgs.mkShell rec {
          name = "standard";
          packages = with pkgs; [ ];
        };
        packages = {
          default = packages.standard;
          standard = pkgs.callPackage ./default.nix { };
        };
      });
}
