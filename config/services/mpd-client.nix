{ config, lib, pkgs, ... }:

{
  services.mpd = {
    	enable = true;
	musicDirectory = "nfs://192.168.1.131/storage/Music/Library";
	dbFile = null;
	playlistDirectory = "/storage/Music/MPD/Playlists";
	extraConfig = ''

	  database {
	  	plugin "proxy"
	  	host "192.168.1.131"
	  	port "6600"	
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
  hardware.pulseaudio.extraConfig = "load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1";
  hardware.pulseaudio.systemWide = true;


}
