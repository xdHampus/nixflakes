# bop
{
  description = "NixOS configuration for all machines";

  inputs = {
    # Core dependencies.
    #nixpkgs.url = "nixpkgs/nixos-unstable";     # primary nixpkgs
    #nixpkgs-unstable.url = "nixpkgs/master";    # for packages on the edge
    home-manager = {
     # url = "github:rycee/home-manager/master";
      url = "github:rycee/home-manager/release-20.09";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };     
      #input.nixpkgs.follows = "nixpkgs";
    };
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    # Extras
    #emacs-overlay.url  = "github:nix-community/emacs-overlay";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    # Old impl / no idea

    nixpkgs.url = "github:nixos/nixpkgs/nixos-20.09";
    nur.url = "github:nix-community/NUR";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    neovim-overlay.url = "github:nix-community/neovim-nightly-overlay";
    master.url = "github:nixos/nixpkgs/master";
    #unstable.url = "nixpkgs/nixos-unstable";     # primary nixpkgs
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ self, home-manager, nur, nixpkgs, ... }:
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

      defaults = { pkgs, ... }: {
        imports = [
          #./cachix.nix # WARNING has to do with building??
          ./modules/common/nix.nix # settings for nix usually seen in configuration.nix
          ./modules/common/sudo.nix # renamed to sudo, controls security.sudo or doas
          ./modules/common/console.nix # WARNING unstable.spleen may cause issues?
          #./modules/hardware/bluetooth.nix # CLUSTER IN common/hardware.nix
          #./modules/hardware/zram.nix
          #./modules/hardware/earlyoom.nix
          ./modules/common/hardware.nix # WARNING deviant look above
          #./modules/common/etcfiles.nix # WARNING FETCHES IMAGES AND CONFIGS?
          ./modules/common/systempkgs.nix # WARNING CHANGE unstable TO nixpkgs
          ./modules/common/locale.nix # TODO MERGE WITH console.nix
          #./modules/services/pulseaudio.nix # IN hardware
          #./modules/services/clamav.nix #
          #./modules/services/openssh.nix #
          ./modules/common/services.nix
        ];
      };
    in
    {
      overlays =
        let
          overlayFiles = listToAttrs (map
            (name: {
              name = removeSuffix ".nix" name;
              value = import (./overlays + "/${name}");
            })
            (attrNames (readDir ./overlays)));
        in
          overlayFiles // {
            nur = final: prev: {
              nur = import inputs.nur { nurpkgs = final.unstable; pkgs = final.unstable; };
            };
            unstable = final: prev: {
              unstable = import inputs.unstable {
                system = final.system;
                config = {
                  allowUnfree = true;
                };
              };
            };
            master = final: prev: {
              master = import inputs.master {
                system = final.system;
                config = {
                  allowUnfree = true;
                };
              };
            };
          };

      nixosConfigurations = {
        worklaptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            [
              defaults
              ./machines/worklaptop/configuration.nix
              ./modules/common/xserver.nix #noidea
              #./modules/hardware/ssd.nix
              ./modules/common/fonts.nix # WARNING unstable pkgs ??
              ./modules/gui/blueman.nix #noidea
              home-manager.nixosModules.home-manager
                ({
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.ham = { ... }: {
                    imports = [
                      ./machines/worklaptop/home.nix # WARNING unstable pkgs
                      ./modules/common/xdg.nix # 
                      ./modules/common/xmonad.nix # 
                      ./modules/services/dunst.nix # 
                      ./modules/services/picom.nix # WARNING nur pkgs
                      ./modules/terminal/alacritty.nix # 
                      ./modules/gui/qutebrowser.nix # 
                      ./modules/gui/firefox.nix # 
                      ./modules/gui/mpv.nix # 
                      ./modules/gui/zathura.nix # 
                      ./modules/editors/emacs.nix # 
                      ./modules/terminal/fish.nix # 
                      ./modules/terminal/git.nix # 
                      ./modules/terminal/bat.nix # 
                      ./modules/terminal/fzf.nix #
                      ./modules/terminal/lsd.nix # 
                      ./modules/terminal/starship.nix # 
                      ./modules/terminal/tmux.nix # 
                      ./modules/services/gpg.nix # 
                    ];
                  };
                })
            ];
          inherit pkgs;
        };
      };
    };
}
