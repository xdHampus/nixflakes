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
        xfce.enable = true;
      };
      displayManager.defaultSession = "xfce";
    };
  };
}
