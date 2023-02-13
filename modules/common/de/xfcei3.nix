{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.common.de.xfcei3;
in {
  options.modules.common.de.xfcei3 = {
    enable = mkEnableOption "xfcei3";
  };
  config = mkIf cfg.enable {
    services = {
      xserver = {
        enable = true;

        # Input
        layout = "dk";
        # Window managers / Desktop enviroments
        desktopManager = {
          #	  default = "xfce";
          xterm.enable = false;
          xfce = {
          enable = true;
          noDesktop = true;
          enableXfwm = false;
          };
        };

        displayManager = {
          defaultSession = "xfce+i3";
          lightdm.enable = true;
        };

        windowManager.i3 = {
          enable = true;
          extraPackages = with pkgs; [
            dmenu
            i3status
          ];     
        };      
      };
    };
  };
}
