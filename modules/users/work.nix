{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.users.work;
in {
  options.modules.users.work = {
    enable = mkEnableOption "work";
  };
  config = mkIf cfg.enable {
    users.users.work = {
      isNormalUser = true;
      home = "/home/work";
      description = "Work User";
      extraGroups = [ "users" "audio" "wheel" "networkmanager" "docker" "vboxusers" "syncthing" ];
    };
  };
}
