{ pkgs, lib, config, ... }:
with lib;                      
let
  cfg = config.modules.dev.profiles.python;
in {
  options.modules.dev.profiles.python = {
    enable = mkEnableOption "python";
  };
  config = mkIf cfg.enable {
    home.packages =  with pkgs; [
      # Standard
      python39
      python39Packages.numpy
      # GUI
      #python39Packages.tkinter
      #python39Packages.matplotlib
    ];
  };
}
