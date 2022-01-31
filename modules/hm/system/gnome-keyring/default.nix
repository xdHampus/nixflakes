{ pkgs, lib, config, ... }:
with lib;                      
let
  cfg = config.modules.system.gnome-keyring;
in {
  options.modules.system.gnome-keyring = {
    enable = mkEnableOption "gnome-keyrinf";
  };
  config = mkIf cfg.enable {
    services.gnome-keyring = {
      enable = true;
      components = [
        "secrets"
        "pkcs11"
      ];
    };
  };
}
