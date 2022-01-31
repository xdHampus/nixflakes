{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.common.xorg;
in {
  options.modules.common.xorg = {
    enable = mkEnableOption "xorg";
  };
  config = mkIf cfg.enable {
    # Machine specific Xorg settings, mainly drivers
    services.xserver = {
      videoDrivers = [ "modesetting" ];
      useGlamor = true;
    };
  };
}
