{ config, lib, pkgs, ... }:

{
  services = {
      lorri.enable = true;
      printing.enable = true;
  };
}
