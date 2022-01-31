{ pkgs, lib, config, ... }:
with lib;                      
let
  cfg = config.modules.de.xfce;
in {
  options.modules.de.xfce = {
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
