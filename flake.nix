{

  description = "NixOS configuration for all machines";

  # Inputs control all dependencies that will be used by the flake in the outputs
  inputs = {
      # Core dependencies.
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
      home-manager.url = "github:nix-community/home-manager";
      # Extra
      nixpkgs-unstable.url = "github:NixOS/nixpkgs/master";
      #nixpkgs-dev.url = "github:xdHampus/nixpkgs/master";
  };


  outputs = inputs@{ self
    , nixpkgs
    , nixpkgs-unstable
    #, nixpkgs-dev
    , home-manager 
  }:

  let

    inherit (builtins) listToAttrs attrValues attrNames readDir;
    inherit (nixpkgs) lib;
    inherit (lib) removeSuffix;

    pkgs = (import nixpkgs) {
      system = "x86_64-linux";
      config = {
        allowUnfree = true;
      };
      overlays = attrValues self.overlays;
    };

  in {

    overlays = {
      unstable = final: prev: {
        unstable = import inputs.nixpkgs-unstable {
          system = final.system;
          config = {
            allowUnfree = true;
          };
        };
      };
      dev = final: prev: {
        dev = import inputs.nixpkgs-dev {
          system = final.system;
          config = {
            allowUnfree = true;
          };
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
          ./hosts/hlp/configuration.nix
          #Home manager
          home-manager.nixosModules.home-manager ({
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users = import ./nix/user-import.nix { 
              users = [ "personal" "guest" "work" ];
              pkgs = nixpkgs;
	          };	          	          	          
          })
      ];
      inherit pkgs;
    };

 	nixosConfigurations.deskserver = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
          ./hosts/deskserver/configuration.nix
          #Home manager
          home-manager.nixosModules.home-manager ({
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

 	nixosConfigurations.hdesktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
          ./hosts/hdesktop/configuration.nix
          #Home manager
          home-manager.nixosModules.home-manager ({
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users = import ./nix/user-import.nix {
              users = [ "personal" "work" ];
              pkgs = nixpkgs;
          	};
          })
      ];
      inherit pkgs;
  };     

  };
}
