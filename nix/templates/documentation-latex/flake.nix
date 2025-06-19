{
  description = "A template for writing documentation with LaTeX";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils, ... }@inputs:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          #config.allowUnfree = true;
          inherit system;
        };
        tex = pkgs.texlive.combine {
          inherit (pkgs.texlive) scheme-full latex-bin latexmk;
        };
      in rec {
        devShells.default = pkgs.mkShell rec {
          name = "docs-dev-shell";
          packages = with pkgs; [ ];
        };
        packages = {
          default = packages.docs;
          docs = pkgs.callPackage ./default.nix {
            pkgs = pkgs;
            tex = tex;
          };
        };
      });
}
