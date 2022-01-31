# Main NixOS Configuration file

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ] 
      ++  (import ./../../modules/module-list.nix)
    ;

  # Misc
  nixpkgs.config.allowUnfree = true;
  
  # Enabled core modules
  modules.common.packages.enable = true;
  modules.de.xfce.enable = true;
  modules.common.boot.uefi.enable = true;
  modules.common.hardware.enable = true;
  modules.common.nix.enable = true;
  modules.common.security.enable = true;
  modules.common.services.enable = true;
  modules.common.sound.enable = true;
  # Other modules
  #modules.services.gnome-keyring = true;

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
    #useDHCP = false;
    firewall.enable = true;
    #firewall.allowPing = true;
    firewall.allowedTCPPorts = [
    	9090
    ];
  };


  # User accounts
  users.users.work = {
    isNormalUser = true;
    home = "/home/work";
    description = "Work User";
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
    python3
    xclip
 ];

  system.stateVersion = "22.05";
}
