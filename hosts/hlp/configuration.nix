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
      #./../../config/services/postgres.nix
      # Credentials
      ./../../config/services/gnome-keyring.nix
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
    hostName = "hlp";
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
    description = "Old Test User";
    extraGroups = [ "users" "audio" "wheel" "networkmanager" "docker" "vboxusers" ];
  };  
  users.users.work = {
    isNormalUser = true;
    home = "/home/work";
    description = "Work User";
    extraGroups = [ "users" "audio" "wheel" "networkmanager" "docker" "vboxusers" ];
  };
  users.users.personal = {
    isNormalUser = true;
    home = "/home/personal";
    description = "Personal User";
    extraGroups = [ "users" "audio" "wheel" "networkmanager" "docker" "vboxusers" ];
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
    pavucontrol
    keepassxc
    micro
 ];

  system.stateVersion = "21.05";
}
