{ pkgs, lib, config, ... }:
with lib;                      
let
  cfg = config.modules.tools.firefox;
in {
  options.modules.tools.firefox = {
    enable = mkEnableOption "firefox";
  };
  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
    };
  };
}
