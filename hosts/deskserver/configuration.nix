# Main NixOS Configuration file

{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ] ++ (import ./../../modules/module-list.nix);

  # Legacy boot settings
  boot.loader.grub = {
    enable = true;
    device = "/dev/sdb";
  };
  
  # Misc
  nixpkgs.config.allowUnfree = true;
  
  # Modules
  modules = {
    # Core
    common = {
      # Machine
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
      servuser.enable = true;
    };
    # Misc
    services = {
      sshd.enable = true;
      borgbackup.personal.music.enable = true;
      mpd.server.enable = true;
      nfs.enable = true;
      githubrunner = {
        enable = true;
        url = "https://github.com/xdHampus/ereolenWrapper";
        tokenFile = "/run/secrets/github-runner/nixos.token";
      };
    };
  };



  # Networking
  networking = {
    hostName = "deskserver";
    networkmanager = {
      enable = true;
      plugins = [ pkgs.networkmanager-openvpn ];
    };
    useDHCP = false;
    firewall.enable = true;
    firewall.allowPing = true;
    firewall.allowedTCPPorts = [
          6600
          22
          111
          2049
          
    ];
    firewall.allowedUDPPorts = [
          6600
          22
          111
          2049
          
    ];
  };


  # Basic packages
  environment.systemPackages = with pkgs; [
    # services
    borgbackup  
    mpd  
 ];
  system.stateVersion = "22.11";
}
