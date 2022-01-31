{ pkgs, lib, config, ... }:
with lib;                      
let
  cfg = config.modules.dev.profiles.kube;
in {
  options.modules.dev.profiles.kube = {
    enable = mkEnableOption "kube";
  };
  config = mkIf cfg.enable {
    home.packages =  with pkgs; [
      kubectl
    ];
  };
}
