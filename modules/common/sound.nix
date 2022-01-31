{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.common.sound;
in {
  options.modules.common.sound = {
    enable = mkEnableOption "sound";
  };
  config = mkIf cfg.enable {
    sound = {
      enable = true;
      mediaKeys.enable = true;
    };
  };
}
