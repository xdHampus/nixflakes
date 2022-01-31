{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.services.mpd.local;
in {
  options.modules.services.mpd.local = {
    enable = mkEnableOption "local";
    musicDirectory = mkOption {
      type = types.str;
      default = "/storage/Music/Library";
    };
    playlistDirectory = mkOption {
      type = types.str;
      default = "/storage/Music/MPD/Playlists";
    };
    extraConfig = mkOption {
      type = types.str;
      default = ''
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
    	#dbFile = "/storage/Music/MPD/mpddb";
    	musicDirectory = cfg.musicDirectory;
    	playlistDirectory = cfg.playlistDirectory;
    	extraConfig = cfg.extraConfig;
    };
    hardware.pulseaudio.extraConfig = "load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1";
    hardware.pulseaudio.systemWide = true;
  };
}
