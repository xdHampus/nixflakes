{ config, pkgs, fetchgit, ... }:
{

  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

    boot = {
      loader = {
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
    };

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  programs = {
    dconf.enable = true;
    adb.enable = true;
    java.enable = true;
  };

  networking = {
    hostName = "worklaptop";
    networkmanager = {
      enable = true;
      packages = [ pkgs.networkmanager_openvpn ];
    };
    useDHCP = false;
    firewall.enable = true;
    firewall.allowPing = true;
  };


  users.users.hamkek = {
    home = "/home/hamkek";
  };



#  virtualisation = import (../../modules/virtualisation/default.nix);


  # Required to use Kodi Zeroconf

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}
