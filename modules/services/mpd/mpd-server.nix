{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.services.mpd.server;
in {
  options.modules.services.mpd.server = {
    enable = mkEnableOption "server";
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
    	musicDirectory = cfg.musicDirectory;
    	playlistDirectory = cfg.playlistDirectory;
    	extraConfig = cfg.extraConfig;
    };
    hardware.pulseaudio.extraConfig = "load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1";
    hardware.pulseaudio.systemWide = true;
  };
}
