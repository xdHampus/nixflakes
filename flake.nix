{
  description = "NixOS configuration for all machines";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/master";
    #nixpkgs-dev.url = "github:xdHampus/nixpkgs/master";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let

      inherit (builtins) listToAttrs attrValues attrNames readDir;
      inherit (nixpkgs) lib;
      inherit (lib) removeSuffix;

      pkgs = (import nixpkgs) {
        system = "x86_64-linux";
        config = { allowUnfree = true; };
        overlays = attrValues self.overlays;
      };
      defaults = { pkgs, ... }: {
        _module.args.nixpkgs-unstable = import inputs.nixpkgs-unstable {
          inherit (pkgs.stdenv.targetPlatform) system;
          config = { allowUnfree = true; };
        };
        _module.args.flake = self;
      };

    in {

      overlays = {
        unstable = final: prev: {
          unstable = import inputs.nixpkgs-unstable {
            system = final.system;
            config = { allowUnfree = true; };
          };
        };
        ncmpcpp = final: prev: {
          ncmpcpp = prev.ncmpcpp.override {
            visualizerSupport = true;
            taglibSupport = true;
          };
        };
      };

      nixosConfigurations.hlp = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          defaults
          ./hosts/hlp/configuration.nix
          home-manager.nixosModules.home-manager
          ({
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users = import ./nix/user-import.nix {
              users = [ "personal" "work" ];
              pkgs = nixpkgs;
            };
            home-manager.extraSpecialArgs = { triScreenSetup = false; };
          })
        ];
        inherit pkgs;
      };

      nixosConfigurations.hdesktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          defaults
          ./hosts/hdesktop/configuration.nix
          home-manager.nixosModules.home-manager
          ({
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users = import ./nix/user-import.nix {
              users = [ "personal" "work" ];
              pkgs = nixpkgs;
            };
            home-manager.extraSpecialArgs = { triScreenSetup = true; };
          })
        ];
        inherit pkgs;
      };

      nixosConfigurations.deskserver = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          defaults
          ./hosts/deskserver/configuration.nix
          home-manager.nixosModules.home-manager
          ({
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users = import ./nix/user-import.nix {
              users = [ "servuser" ];
              pkgs = nixpkgs;
            };
          })
        ];
        inherit pkgs;
      };

      packages.x86_64-linux = {
        exam-monitor = pkgs.callPackage ./nix/pkgs/exam-monitor.nix { };
      };

      templates = rec {

        default = standard;
        standard = {
          path = ./nix/templates/standard;
          description = "A standard flake template";
        };

        documentation = {
          path = ./nix/templates/documentation-latex;
          description = "A template for writing documentation with LaTeX";
        };

      };

    };
}
