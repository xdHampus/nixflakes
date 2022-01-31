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
      autoOptimiseStore = true;
      package = pkgs.nixFlakes;

      # Automate garbage collection
      gc = {
        automatic = true;
        dates     = "weekly";
        options   = "--delete-older-than 7d";
      };

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
