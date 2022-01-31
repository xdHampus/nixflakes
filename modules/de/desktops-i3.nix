{ config, lib, pkgs, ... }:

{
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
}
