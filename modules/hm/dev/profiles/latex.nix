{ pkgs, lib, config, ... }:
with lib;                      
let
  cfg = config.modules.dev.profiles.latex;
in {
  options.modules.dev.profiles.latex = {
    enable = mkEnableOption "latex";
  };
  config = mkIf cfg.enable {
    home.packages =  with pkgs; [
      texstudio 
      texlive.combined.scheme-medium   
      zathura
    ];
  };
}
