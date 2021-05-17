{ config, lib, pkgs, ... }:

{
  services.openssh.enable = true;
  services.sshd = {
        enable = true;
  };
}









