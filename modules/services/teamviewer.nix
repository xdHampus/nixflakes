{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.services.teamviewer;
in {
  options.modules.services.teamviewer = {
    enable = mkEnableOption "teamviewer";
  };
  config = mkIf cfg.enable {
    services.teamviewer.enable = true;
  };
}
