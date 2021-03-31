{

  description = "NixOS configuration for all machines";

  #Testing

  #Launch
  #
  #Create test container
  #nixos-container start flake-test --flake /home/hampus/documents/repo/nixflakes#container
  #Test container
  #nixos-container start flake-test
  #See response
  #curl http://flake-test/
  #
  #Build
  #nix build /path/to/my-flake#nixosConfigurations.container.config.system.build.toplevel


  # Inputs control all dependencies that will be used by the flake in the outputs
  inputs = {
      # Core dependencies.
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";     # primary nixpkgs


      home-manager = {
        url = "github:rycee/home-manager/master";
        inputs = {
          nixpkgs.follows = "nixpkgs";
        };
      };


      #nixpkgs-unstable.url = "github:NixOS/nixpkgs/master";    # for packages on the edge

  };


  outputs = { self, nixpkgs, home-manager }: {


    nixosConfigurations.hlaptop = nixpkgs.lib.nixosSystem {
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
