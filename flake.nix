{
  description = "NixOS configuration for all machines";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/master";
    #nixpkgs-dev.url = "github:xdHampus/nixpkgs/master";
  };

  outputs = inputs@{ self, nixpkgs, nixos-unstable, nixpkgs-unstable, home-manager, ... }:
    let

      inherit (builtins) listToAttrs attrValues attrNames readDir;
      inherit (nixpkgs) lib;
      inherit (lib) removeSuffix;

      pkgs = (import nixpkgs) {
        system = "x86_64-linux";
        config = { 
          allowUnfree = true; 
          nvidia.acceptLicense = true;
          };
        overlays = attrValues self.overlays;
      };
      defaults = { pkgs, ... }: {
        _module.args.nixpkgs-unstable = import inputs.nixpkgs-unstable {
          inherit (pkgs.stdenv.targetPlatform) system;
          config = { allowUnfree = true; nvidia.acceptLicense = true; };
        };
        _module.args.flake = self;
        _module.args.nixos-unstable = import inputs.nixos-unstable {
          inherit (pkgs.stdenv.targetPlatform) system;
          config = { allowUnfree = true; nvidia.acceptLicense = true; };
        };
        
      };

    in {

      overlays = {
        unstable = final: prev: {
          unstable = import inputs.nixpkgs-unstable {
            system = final.system;
            config = { allowUnfree = true; nvidia.acceptLicense = true; };
          };
        };
        nixos-unstable = final: prev: {
          nixos-unstable = import inputs.nixos-unstable {
            system = final.system;
            config = { allowUnfree = true; nvidia.acceptLicense = true; };
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
            home-manager.users.personal = import ./users/personal/home.nix;
            home-manager.users.work = import ./users/work/home.nix;
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
            home-manager.backupFileExtension = "hmbkp";

			home-manager.users = import ./nix/user-import.nix {
				users = [ "personal" "work" ];
				pkgs = nixpkgs;
			};
            #home-manager.users.personal = import ./users/personal/home.nix;
            #home-manager.users.work = import ./users/work/home.nix;
            home-manager.extraSpecialArgs = { triScreenSetup = true; };
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
