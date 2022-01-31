{ pkgs, lib, config, ... }:
with lib;                      
let
  cfg = config.modules.common.de.xfce;
in {
  options.modules.common.de.xfce = {
    enable = mkEnableOption "xfce";
  };
  config = mkIf cfg.enable {
    services = {
      xserver = {
        enable = true;

        # Input
        layout = "dk";
        libinput = {
          enable = true;
        };

        desktopManager = {
  	      xterm.enable = true;
          xfce = {
  	        enable = true;
        	  enableXfwm = true;
  	      };
        };
        displayManager.defaultSession = "xfce";
      };
    };
  };
}
