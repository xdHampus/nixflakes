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


  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, nixpkgs-dev, home-manager }:
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
              users = [ "hadmin" ];
              pkgs = nixpkgs;
          	};
          })
      ];
      inherit pkgs;
    };  

    nixosConfigurations.hlaptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
            
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
      inherit pkgs;
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
              users = [ 
              	"hamtest"
              	"personal"
              	"work" 
              ];
              pkgs = nixpkgs;
	          };	          	          	          
          })
      ];
      inherit pkgs;
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


 #           nixpkgs.overlays = [ 
#          		(self: super: {
#	    			  ncmpcpp = super.ncmpcpp.override { 
  #						visualizerSupport = true;
  #						taglibSupport = true;
 # 					}; 
#	  			})
 #         		(self: super: {
#	    			openssh = super.openssh.override {
#	      				hpnSupport = true;
#	      				withKerberos = true;
#	      				kerberos = self.libkrb5;
#	    			};
#	  			}) 
#			];

