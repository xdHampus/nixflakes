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
      ./../../config/common/desktops.nix
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
      # Locales
      ./../../config/common/security.nix

      # Extra
      #
      # Postgres
      ./../../config/services/postgres.nix
      # Docker
      ./../../config/virtualisation/docker.nix
      # Credentials
      #./../../config/services/gnome-keyring.nix
    ];

  # Misc
  nixpkgs.config.allowUnfree = true;

  # Machine specific Xorg settings, mainly drivers
  services.xserver = {
    videoDrivers = [ "modesetting" ];
    useGlamor = true;
  };

  # Networking
  networking = {
    hostName = "hlaptop";
    networkmanager = {
      enable = true;
      packages = [ pkgs.networkmanager_openvpn ];
    };
    useDHCP = false;
    firewall.enable = true;
    firewall.allowPing = true;
  };


  # User accounts
  users.users.hamtest = {
    isNormalUser = true;
    home = "/home/hamtest";
    description = "Hamtest";
    extraGroups = [ "users" "audio" "wheel" "networkmanager" "docker"];
  };

  # Nix config
  nix.allowedUsers = [ "@wheel" ];
  nix.trustedUsers = [ "root" "@wheel"  ];



  # Basic packages
  environment.systemPackages = with pkgs; [
    
    # SOCIAL
    discord
    weechat
    # UTILITY
    pavucontrol
    keepassxc
    # DEV
    jdk
    #jetbrains.idea-ultimate
    atom
    postgresql
    dotnet-sdk_5
    # MAINTAINED NIXPKGS
    unstable.quich

 ];





  system.stateVersion = "21.05";

}
