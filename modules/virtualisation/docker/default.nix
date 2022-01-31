{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.virtualisation.docker;
in {
  options.modules.virtualisation.docker = {
    enable = mkEnableOption "docker";
  };
  config = mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
    };
  };
}
