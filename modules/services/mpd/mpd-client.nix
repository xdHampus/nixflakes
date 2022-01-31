{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.services.mpd.client;
in {
  options.modules.services.mpd.client = {
    enable = mkEnableOption "client";
    
    musicDirectory = mkOption {
      type = types.str;
      default = "/storage/Music/Library";
    };
    playlistDirectory = mkOption {
      type = types.str;
      default = "/storage/Music/MPD/Playlists";
    };
    host.address = mkOption {
      type = types.str;
      default = "192.168.1.131";
    };
    host.port = mkOption {
      type = types.str;
      default = "6060";
    };
    fileProtocol = mkOption {
      type = types.str;
      default = "nfs";
    };
    extraConfig = mkOption {
      type = types.str;
      default = ''
          	  database {
          	  	plugin "proxy"
          	  	host "${cfg.host.address}"
          	  	port "${cfg.host.port}"	
          	  }
            	  audio_output {
             	    type "pulse" # MPD must use Pulseaudio
                	name "Pulseaudio" # Whatever you want
             	    #server "127.0.0.1" # MPD must connect to the local sound server  
          	  }
          	  audio_output {
          	      type                    "fifo"
          	      name                    "my_fifo"
          	      path                    "/tmp/mpd.fifo"
          	      format                  "44100:16:2"
          	  }
        	'';
    };  
  };
  config = mkIf cfg.enable {
    services.mpd = {
    	enable = true;
    	musicDirectory = cfg.fileProtocol + "//" + cfg.host.address + cfg.musicDirectory;
    	dbFile = null; #use host db
    	playlistDirectory = cfg.playlistDirectory;
    	extraConfig = cfg.extraConfig;
    };
    hardware.pulseaudio.extraConfig = "load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1";
    hardware.pulseaudio.systemWide = true;
  };
}
