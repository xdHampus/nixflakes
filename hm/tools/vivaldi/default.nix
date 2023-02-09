{ pkgs, lib, config, ... }:
with lib;                      
let
  cfg = config.modules.tools.vivaldi;
in {
  options.modules.tools.vivaldi = {
    enable = mkEnableOption "vivaldi";
  };
  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
    };
  };
}
