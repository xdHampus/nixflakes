{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.common.boot.uefi;
in {
  options.modules.common.boot.uefi = {
    enable = mkEnableOption "uefi";
  };
  config = mkIf cfg.enable {
    boot.loader = {
        efi = {
          canTouchEfiVariables = true;
        };
        grub = {
          enable = true;
          efiSupport = true;
          device = "nodev";
          useOSProber = true;
        };
    };
  };
}
