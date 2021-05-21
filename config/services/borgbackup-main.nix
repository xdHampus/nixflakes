{ config, lib, pkgs, ... }:

{

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
    encryption.mode = none;
    environment.BORG_RSH = "ssh -i /run/keys/deskserver_rsh";
    repo = "ssh://servuser@192.168.1.131:23/storage/backups/personalmain";
    compression = "auto,zstd";
    startAt = "daily";
  };


}
