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
        			type "null"
        			name "MPD Server"
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
  };
}
