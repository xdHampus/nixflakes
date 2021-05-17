{ config, lib, pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;

      # Input
      layout = "dk";
      
      # Window managers / Desktop enviroments
        displayManager = {
          defaultSession = "none+bspwm";
          lightdm.enable = true;
          #lightdm.greeters.mini.enable = true;
        };
        windowManager.bspwm.enable = true;      

    };
  };
}
