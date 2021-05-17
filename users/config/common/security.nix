{ config, lib, pkgs, ... }:

{
  # Sudo
  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
  };
}
