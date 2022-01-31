{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.services.borgbackup.personal.main;
in {
  options.modules.services.borgbackup.personal.main = {
    enable = mkEnableOption "main";
  };
  config = mkIf cfg.enable {
    services.borgbackup.jobs.personalmain = {
      paths = [ 
  	  "/storage/Downloads"
  	  "/storage/Host"
  	  "/storage/Pictures"
  	  "/storage/Repo"
  	  "/storage/Workspace"
  	  "/storage/Documents"
  	  "/storage/Games"
  	  "/storage/Programs"
  	  "/storage/Videos"
      ];
  	exclude = [
  		"'**/.cache'"	
  	];
      encryption.mode = "none";									
      environment.BORG_RSH = "ssh -i /run/keys/deskserver_rsh ";
      repo = "ssh://servuser@192.168.1.131:22/storage/backups/personalmain";
      compression = "auto,zstd";
      startAt = "daily";
  	 prune.keep = {
      	within = "1d";
      	daily = 7; 
  		weekly = 4;
  		monthly = 3;
      };
    };
  };
}
