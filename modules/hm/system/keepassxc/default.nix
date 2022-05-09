{ pkgs, lib, config, ... }:
with lib;                      
let
  cfg = config.modules.system.keepassxc;
in {
  options.modules.system.keepassxc = {
    enable = mkEnableOption "git for github";
  };
  config = mkIf cfg.enable {
    home.packages =  with pkgs; [
      keepassxc
    ];
    home.file.keepassxcConfiguration = {
        source = ./keepassxc.ini;
        target = ".config/keepassxc/keepassxc.ini";
    };

  };
}
