{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.common.sound;
in {
  options.modules.common.sound = {
    enable = mkEnableOption "sound";
  };
  config = mkIf cfg.enable {
    hardware = {
      pulseaudio.enable = true;
      pulseaudio.package = pkgs.pulseaudioFull;
    };
    sound = {
      enable = true;
      mediaKeys.enable = true;
    };
  };
}
