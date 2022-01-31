{ config, lib, pkgs, ... }:

{

  services.borgbackup.jobs.personalmain = {
    paths = "/storage/Music";
    encryption.mode = "none";									
    environment.BORG_RSH = "ssh -i /run/keys/deskserver_rsh ";
    repo = "ssh://servuser@192.168.1.131:22/storage/backups/music";
    compression = "auto,zstd";
    startAt = "weekly";
    prune.keep = {
    	within = "2w"; 
		weekly = 4;
		monthly = 3;
    }
  };


}
