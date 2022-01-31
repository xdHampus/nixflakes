{ pkgs, lib, config, ... }:
with lib;                      
let
  cfg = config.modules.dev.profiles.rest;
in {
  options.modules.dev.profiles.rest = {
    enable = mkEnableOption "rest";
  };
  config = mkIf cfg.enable {
    home.packages =  with pkgs; [
      # Development Tools
      postman
    ];
  };
}
