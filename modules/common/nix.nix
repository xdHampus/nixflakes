{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.common.nix;
in {
  options.modules.common.nix = {
    enable = mkEnableOption "nix";
  };
  config = mkIf cfg.enable {
    # Nix config
    nix = {
      settings = {
        allowed-users = [ "@wheel" ];
        trusted-users = [ "root" "@wheel"  ];
        auto-optimise-store = true;
      };
      
      # Automate garbage collection
      gc = {
        automatic = true;
        dates     = "weekly";
        options   = "--delete-older-than 7d";
      };
      package = pkgs.nixFlakes;

      # Avoid unwanted garbage collection when using nix-direnv
      extraOptions = ''
        experimental-features = nix-command flakes
        keep-outputs     = true
        keep-derivations = true
        builders-use-substitutes = true #flake
      '';
    };
  };
}
