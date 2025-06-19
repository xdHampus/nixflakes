# Main NixOS Configuration file

{ config, pkgs, nixpkgs-unstable, flake, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ] ++ (import ./../../modules/module-list.nix);

  #nixpkgs.config.allowUnfree = true;
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
      #  
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
           "moto g30"
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
    	"displaylink"
    ];
    displayManager.session = [
   		{ manage = "desktop";
    	    name = "xterm";
    	    start = ''
    	      ${pkgs.xterm}/bin/xterm -ls &
    	      waitPID=$!
    	    '';
   	  }
    ];
  };
  services.tailscale.enable = true;
  hardware.nvidia = {
  	modesetting.enable = true;
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
     nixpkgs-unstable.xdg-desktop-portal-xapp
     pkgs.xdg-desktop-portal-gnome
     pkgs.xdg-desktop-portal-gtk
     pkgs.xdg-desktop-portal

    ];
  };

    
  # Networking
  networking = {
    hostName = "hlp";
    networkmanager = {
      enable = true;
      plugins = [ pkgs.networkmanager-openvpn ];
    };
    #useDHCP = true;
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
    nixpkgs-unstable.vscode
    flake.packages.x86_64-linux.exam-monitor
    syncthingtray
    onlyoffice-bin
    nixpkgs-unstable.zoom-us
    nixpkgs-unstable.unityhub
    nixpkgs-unstable.xdg-utils    
 ];

  system.stateVersion = "25.05";
}
