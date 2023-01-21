# Main NixOS Configuration file

{ config, pkgs, nixpkgs-unstable, flake, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ] ++ (import ./../../modules/module-list.nix);

  nixpkgs.config.allowUnfree = true;

  # Modules
  modules = {
     # Core
     common = {
      # Machine
      boot.uefi.enable = true;
      hardware.enable = true;
      xorg.enable = true;
      de.xfce.enable = true;
      # Misc
      nix.enable = true; 
      security.enable = true;
      services.enable = true;
      sound.enable = true; 
      packages.enable = true;
      locale.dk.enable = true;
     };
     # Users
     users = {
      work.enable = true;
      personal.enable = true;
     };
     services = {
       syncthing = {
        enable = true;
        vault = {
          enable = true;
          devices = [ 
           "moto g(30)"
           "hdesktopw"
           ];
        };
        code = {
          enable = true;
          devices = [ 
           "hdesktopw"
          ];
        };
        shared = {
          enable = true;
          devices = [ 
           "hdesktopw" 
          ];
        };
       };
     };
     virtualisation.docker.enable = true;
  };
  

  # Machine specific Xorg settings, mainly drivers
  services.xserver = {
    videoDrivers = [ 
    	"nvidia" 
    ];
  };
  hardware.nvidia = {
  	modesetting.enable = true;
  };

    
  # Networking
  networking = {
    hostName = "hlp";
    networkmanager = {
      enable = true;
      plugins = [ pkgs.networkmanager-openvpn ];
    };
    #useDHCP = false;
    firewall = {
      enable = true;
      allowPing = true;
    };
  };

  # Basic packages
  environment.systemPackages = with pkgs; [
    nixpkgs-unstable.discord
    flake.packages.x86_64-linux.exam-monitor
    syncthingtray
 ];

  system.stateVersion = "22.11";
}
