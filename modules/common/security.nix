{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.common.security;
in {
  options.modules.common.security = {
    enable = mkEnableOption "security";
  };
  config = mkIf cfg.enable {
    # Sudo
    security.sudo = {
      enable = true;
      wheelNeedsPassword = true;
    };
  };
}
