{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.virtualisation.virtualbox;
in {
  options.modules.virtualisation.virtualbox = {
    enable = mkEnableOption "virtualbox";
  };
  config = mkIf cfg.enable {
    # Virtualization / other os's support
    virtualisation.virtualbox = {
      host = {
        enable = true;
        enableExtensionPack = true;
      };
      guest.enable = false;
    };
    #users.extraGroups.vboxusers.members = [ "hamtest" ];
  };
}
