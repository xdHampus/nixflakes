{ config, lib, pkgs, ... }:

{
  boot.loader = {
      efi = {
        canTouchEfiVariables = true;
      };
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
        version = 2;
      };
  };
}
