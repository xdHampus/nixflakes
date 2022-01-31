{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.common.de.nonei3;
in {
  options.modules.common.de.nonei3 = {
    enable = mkEnableOption "nonei3";
  };
  config = mkIf cfg.enable {
    services = {
      xserver = {
        enable = true;

        # Input
        layout = "dk";

        # Window managers / Desktop enviroments
        desktopManager = {
          xterm.enable = false;
        };

        displayManager = {
          defaultSession = "none+i3";
          lightdm.enable = true;
        };

        windowManager.i3 = {
          enable = true;
          package = pkgs.i3-gaps;
          extraPackages = with pkgs; [
            dmenu
            i3status
            i3lock
            i3blocks
          ];     
        };      
      };
    };
  };
}
