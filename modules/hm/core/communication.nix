{ pkgs, lib, config, ... }:
with lib;                      
let
  cfg = config.modules.core.communication;
in {
  options.modules.core.communication = {
    enable = mkEnableOption "communication";
  };
  config = mkIf cfg.enable {
    home.packages =  with pkgs; [
    	discord
    	#teams
    	zoom-us
    ];
  };
}
