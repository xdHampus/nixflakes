{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.users.personal;
in {
  options.modules.users.personal = {
    enable = mkEnableOption "personal";
  };
  config = mkIf cfg.enable {
    users.users.personal = {
      isNormalUser = true;
      home = "/home/personal";
      description = "Personal User";
      extraGroups = [ "users" "audio" "mpd"  "wheel" "networkmanager" "docker" "vboxusers" "syncthing" ];
    };
  };
}
