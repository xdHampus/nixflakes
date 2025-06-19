{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.services.gnome-keyring;
in {
  options.modules.services.gnome-keyring = {
    enable = mkEnableOption "gnome-keyring";
  };
  config = mkIf cfg.enable {
    services.gnome.gnome-keyring.enable = true;
  };
}
