{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.users.guest;
in {
  options.modules.users.guest = {
    enable = mkEnableOption "guest";
  };
  config = mkIf cfg.enable {
    # User accounts
    users.users.guest = {
      isNormalUser = true;
      home = "/home/guest";
      description = "Guest User";
      extraGroups = [ "users" "audio" "networkmanager" ];
    };
  };
}
