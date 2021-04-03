{

  description = "NixOS configuration for all machines";

  # Inputs control all dependencies that will be used by the flake in the outputs
  inputs = {
      # Core dependencies.
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

      home-manager = {
        url = "github:rycee/home-manager/master";
        inputs = {
          nixpkgs.follows = "nixpkgs";
        };
      };

      # Extra
      nixpkgs-unstable.url = "github:NixOS/nixpkgs/master";
      nixpkgs-dev.url = "github:xdHampus/nixpkgs/master";


  };


  outputs = { self, nixpkgs, nixpkgs-unstable, nixpkgs-dev, home-manager }: {


    nixosConfigurations.hlaptop = nixpkgs.lib.nixosSystem 
    { pkgs, ... }:
      let
        unstable = nixpkgs-unstable;
      in
    {
      system = "x86_64-linux";
      modules = [
          #Host config
          ./hosts/hlaptop/configuration.nix

          #Home manager
          home-manager.nixosModules.home-manager ({
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users = import ./nix/user-import.nix { 
              users = [ "hamtest" ];
              pkgs = nixpkgs;
	          };
          })
      ];
    };

    #Test headless server
    nixosConfigurations.container = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules =
        [ ({ pkgs, ... }: {
            boot.isContainer = true;

            # Let 'nixos-version --json' know about the Git revision
            # of this flake.
            system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;

            # Network configuration.
            networking.useDHCP = false;
            networking.firewall.allowedTCPPorts = [ 80 ];

            # Enable a web server.
            services.httpd = {
              enable = true;
              adminAddr = "morty@example.org";
            };
          })
        ];
    };


  };
}
