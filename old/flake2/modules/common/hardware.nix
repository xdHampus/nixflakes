{ pkgs, ... }:
{
  hardware = {
    enableRedistributableFirmware = true;
#    enableAllFirmware = true;
    cpu.intel.updateMicrocode = true;
    pulseaudio.enable = true;
    pulseaudio.package = pkgs.pulseaudioFull;
    bluetooth.enable = true;
    opengl.enable = true;
    opengl.driSupport = true;
  };
}
