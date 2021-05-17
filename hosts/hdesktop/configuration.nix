# Main NixOS Configuration file

{ config, pkgs, ... }:

{
  imports =
    [
      # Core configuration
      #
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # System packages
      ./../../config/common/packages-system.nix
      # Include an Xorg configuration
      ./../../config/common/desktops-i3.nix
      # Bootloader
      ./../../config/common/bootloader-uefi.nix
      # Default hardware settings
      ./../../config/common/hardware-default-intel.nix
      # Nix config
      ./../../config/common/nix.nix
      # Security - (Sudo, DOAS, wheel etc.)
      ./../../config/common/security.nix
      # Services
      ./../../config/common/services.nix
      # Sound
      ./../../config/common/sound.nix
      # Locals
      ./../../config/common/locale-dk.nix

      # Extra
      #
      # Postgres
      ./../../config/services/postgres.nix
      # Docker
      #./../../config/virtualisation/docker.nix
      # Virtual Box
      ./../../config/virtualisation/virtualbox.nix
      # Credentials
      ./../../config/services/gnome-keyring.nix
      # MPD
      ./../../config/services/mpd.nix
    ];

  # Misc
  nixpkgs.config.allowUnfree = true;

  # Machine specific Xorg settings, mainly drivers
  services.xserver = {
    videoDrivers = [ 
    	"nvidia" 
    ];
    # Fix mouse issue
    config = ''
        Section "InputClass"
                Identifier     "Mouse Remap"
                 MatchProduct   "Mad Catz Mad Catz R.A.T.TE"
                MatchDevicePath "/dev/input/event*"
                Option         "ButtonMapping" " 1 2 3 4 5 6 7 8 9 10 11 12 0 0 0"
                Option        "ZAxisMapping" "4 5 6 7"
        EndSection	    
    '';
  };
  hardware.nvidia = {
  	modesetting.enable = true;
  };

  # Networking
  networking = {
    hostName = "hdesktop";
    networkmanager = {
      enable = true;
      packages = [ pkgs.networkmanager_openvpn ];
    };
    useDHCP = false;
    firewall.enable = true;
    firewall.allowPing = true;
  };


  # User accounts
  users.users.hadmin = {
    isNormalUser = true;
    home = "/home/hadmin";
    description = "Hadmin";
    extraGroups = [ "users" "audio" "mpd"  "wheel" "networkmanager" "docker" "vboxusers" ];
  };

  # Multi monitor
  # also configured per user
  # due to issues with nvidia
  services.xserver.xrandrHeads = [
     {
      output = "DVI-D-0";
      primary = false;
      monitorConfig = "Option \"Left-off\" \"HDMI-0\"";
    }
    {
      output = "HDMI-0";
      primary = true;
      monitorConfig = "Option \"Left-off\" \"VGA-0\"";
    }
    {
      output = "VGA-0";
      primary = false;
    }
 ];   


  # Nix config
  nix.allowedUsers = [ "@wheel" ];
  nix.trustedUsers = [ "root" "@wheel"  ];

  programs.java = with pkgs; {
    enable = true;
    package = jdk;
  };

  # Basic packages
  environment.systemPackages = with pkgs; [
    sxhkd    

    # SOCIAL
    discord
    weechat
    # UTILITY
    pavucontrol
    keepassxc
    # DEV
    jetbrains.idea-ultimate
    atom
    genymotion
    jetbrains.clion
    gcc
    gdb
    ninja
    cmake
	pgweb

    #postgresql
    #dotnet-sdk_5
    # AUDIO
    ncmpcpp    

 ];

  system.stateVersion = "21.05";
}
