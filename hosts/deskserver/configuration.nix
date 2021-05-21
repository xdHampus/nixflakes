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
      ./../../config/de/xfce.nix
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
      # Locales
      ./../../config/common/security.nix

      # Extra
      #
      # Postgres
      #./../../config/services/postgres.nix
      # Docker
      #./../../config/virtualisation/docker.nix
      # Virtual Box
      #./../../config/virtualisation/virtualbox.nix
      # Credentials
      ./../../config/services/gnome-keyring.nix
      # SSH
      ./../../config/services/sshd.nix
    ];

  # Legacy boot settings
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sdb";
  };
  # Misc
  nixpkgs.config.allowUnfree = true;


  # Machine specific Xorg settings, mainly drivers
  services.xserver = {
    videoDrivers = [ "modesetting" ];
    useGlamor = true;
  };

  # Networking
  networking = {
    hostName = "deskserver";
    networkmanager = {
      enable = true;
      packages = [ pkgs.networkmanager_openvpn ];
    };
    useDHCP = false;
    firewall.enable = true;
    firewall.allowPing = true;
  };

  


  # User accounts
  users.users.servuser = {
    isNormalUser = true;
    home = "/home/servuser";
    description = "ServerUser";
    extraGroups = [ "users" "audio" "wheel" "networkmanager" ];
  };


  # Nix config
  nix.allowedUsers = [ "@wheel" ];
  nix.trustedUsers = [ "root" "@wheel"  ];

  programs.java = with pkgs; {
    enable = true;
    package = jdk;
  };

  # Basic packages
  environment.systemPackages = with pkgs; [
    # services
    borgbackup    

    #.NET
    dotnet-sdk_5 dotnet-sdk_3 dotnet-sdk
    dotnetCorePackages.net_5_0 dotnetCorePackages.netcore_3_1 dotnet-netcore  
    dotnetPackages.Nuget
	
 ];





  system.stateVersion = "21.05";

}
