# Main NixOS Configuration file

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ] ++ (import ./../../modules/module-list.nix);

  # Misc
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
      guest.enable = true;
      personal.enable = true;
     };
     # Misc
     services = {
     
     };
     virtualisation.docker.enable = true;

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

  system.stateVersion = "22.05";
}
