{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.common.services;
in {
  options.modules.common.services = {
    enable = mkEnableOption "services";
  };
  config = mkIf cfg.enable {
    services = {
        #lorri.enable = true;
        printing.enable = true;
    };
  };
}
