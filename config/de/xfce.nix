{ config, lib, pkgs, ... }:

{
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
}
