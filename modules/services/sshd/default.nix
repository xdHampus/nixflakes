{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.services.sshd;
in {
  options.modules.services.sshd = {
    enable = mkEnableOption "sshd";
  };
  config = mkIf cfg.enable {
    services.openssh.enable = true;
    services.sshd = {
          enable = true;
    };
  };
}
