{ pkgs, lib, config, ... }:
with lib;                      
let
  cfg = config.modules.dev.profiles.java;
in {
  options.modules.dev.profiles.java = {
    enable = mkEnableOption "java";
  };
  config = mkIf cfg.enable {
    home.packages =  with pkgs; [
      # Tools
    	jetbrains.idea-ultimate
      maven
    ];
    programs.java = with pkgs; {
      enable = true;
      package = jdk;
    };
  };
}
