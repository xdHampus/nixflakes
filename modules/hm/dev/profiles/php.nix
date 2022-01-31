{ pkgs, lib, config, ... }:
with lib;                      
let
  cfg = config.modules.dev.profiles.php;
in {
  options.modules.dev.profiles.php = {
    enable = mkEnableOption "php";
  };
  config = mkIf cfg.enable {
    home.packages =  with pkgs; [
      # Tools
    	micro
    	gitFull
    	chromium #dusk
    	# Dev
    	php80
		  php80Packages.composer
		  docker-compose
    ];
  };
}
