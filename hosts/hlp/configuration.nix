# Main NixOS Configuration file

{ config, pkgs, nixpkgs-unstable, flake, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ] ++ (import ./../../modules/module-list.nix);

  nixpkgs.config.allowUnfree = true;
services.hardware.bolt.enable = true;
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
      #sound.enable = true; 
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
           "hdesktop" "hdesktopw"
           ];
        };
        code = {
          enable = true;
          devices = [ 
           "hdesktop" "hdesktopw"
          ];
        };
        shared = {
          enable = true;
          devices = [ 
           "hdesktop" "hdesktopw" 
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


	sound.enable = false;
    hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
	  enable = true;
	  alsa.enable = true;
	  alsa.support32Bit = true;
	  pulse.enable = true;
	  #jack.enable = true;
	};

  # Basic packages
  environment.systemPackages = with pkgs; [
    nixpkgs-unstable.discord
    flake.packages.x86_64-linux.exam-monitor
    syncthingtray
 ];

  system.stateVersion = "23.05";
}
