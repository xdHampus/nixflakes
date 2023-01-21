{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.users.servuser;
in {
  options.modules.users.servuser = {
    enable = mkEnableOption "servuser";
  };
  config = mkIf cfg.enable {
    users.users.servuser = {
      isNormalUser = true;
      home = "/home/servuser";
      description = "ServerUser";
      extraGroups = [ "users" "audio" "wheel" "networkmanager" ];
    };
  };
}
