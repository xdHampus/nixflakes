{ config, lib, pkgs, ... }:

{
  services.mpd = {
    	enable = true;
    	#dbFile = "/storage/Music/MPD/mpddb";
	musicDirectory = "/storage/Music/Library";
	playlistDirectory = "/storage/Music/MPD/Playlists";
	extraConfig = ''
  	  audio_output {
   	    type "pulse" # MPD must use Pulseaudio
      	    name "Pulseaudio" # Whatever you want
      	    #server "127.0.0.1" # MPD must connect to the local sound server  
	  }
	'';
  };
  hardware.pulseaudio.extraConfig = "load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1";
  hardware.pulseaudio.systemWide = true;


}