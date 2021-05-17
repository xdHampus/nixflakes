{ config, lib, pkgs, ... }:

{
  # Virtualization / other os's support
  virtualisation.virtualbox = {
    host = {
      enable = true;
      enableExtensionPack = true;
    };
    guest.enable = false;
  };
  # WARNING Add appropriate user in host configuration.nix
  #users.extraGroups.vboxusers.members = [ "hamtest" ];
}
