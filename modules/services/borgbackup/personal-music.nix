{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.services.borgbackup.personal.music;
in {
  options.modules.services.borgbackup.personal.music = {
    enable = mkEnableOption "main";
  };
  config = mkIf cfg.enable {
    services.borgbackup.jobs.personalmain = {
       paths = "/storage/Music";
       encryption.mode = "none";									
       #environment.BORG_RSH = "ssh -i /run/keys/deskserver_rsh ";
       repo = "/storage/backups/music";
       compression = "auto,zstd";
       startAt = "weekly";
       prune.keep = {
       	within = "2w"; 
    		weekly = 3;
    		monthly = 2;
    		yearly = 1;
       };
     };
  };
}
