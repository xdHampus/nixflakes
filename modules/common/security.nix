{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.common.security;
in {
  options.modules.common.security = {
    enable = mkEnableOption "security";
  };
  config = mkIf cfg.enable {
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    services.pcscd.enable = true;
    security.sudo = {
      enable = true;
      wheelNeedsPassword = true;
    };
  };
}
