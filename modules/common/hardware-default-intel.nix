{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.common.hardware;
in {
  options.modules.common.hardware = {
    enable = mkEnableOption "common-hardware";
  };
  config = mkIf cfg.enable {
    hardware = {
      enableRedistributableFirmware = true;
      enableAllFirmware = true;
      cpu.intel.updateMicrocode = true;
      #pulseaudio.enable = true;
      #pulseaudio.package = pkgs.pulseaudioFull;
      bluetooth.enable = true;
      nvidia.open = true;
      #nvidia.package = pkgs.linuxPackages.nvidiaPackages.latest;
      graphics.enable = true;
  };
  services.xserver.videoDrivers = [ "intel" "nvidia" ];    
  };
}
