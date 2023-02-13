{ config, lib, pkgs, stdenv, triScreenSetup ? false, ... }:

let
  
  defaultPkgs = with pkgs; [
    binutils-unwrapped
    stow
  	xclip
  	feh
  	scrot
    micro
	rofi	
  ];
  
  
in
{

  programs.home-manager.enable =  true;
  imports = [ ] ++ (import ./../../hm/module-list.nix);

  # Define modules
  modules = 
  		{
        system.i3.enable = triScreenSetup;
        system.gnome-keyring.enable = true;
        dev = {
          git.github.enable = true;
          vscode.enable = true;
          profiles = {
            java.enable = true;
          };
        };
        #system.keepassxc.enable = true;
        tools = {
          firefox.enable = true;
          alacritty = if triScreenSetup
       	    then {default.enable = true;}
       	    else {basic.enable = true;};
          #micro.enable = true;
        };  		  
  		};
  

  
  xdg.enable = true;

  xdg.configFile =  lib.mkIf triScreenSetup {
    nvidiaSettings = {
  		source = ./../../hosts/hdesktop/files/.nvidia-settings-rc;
  		target = "./../.nvidia-settings-rc";
  	};
  	leftWallpaper = {
  		source = ./../../resources/images/triScreenBg/33.png;
  		target = "./wallpapers/left.png";
  	};
  	centerWallpaper = {
  		source = ./../../resources/images/triScreenBg/34.png;
  		target = "./wallpapers/center.png";
  	};
  	rightWallpaper = {
  		source = ./../../resources/images/triScreenBg/37.png;
  		target = "./wallpapers/right.png";
  	};
  };

  home = {
    username      = "personal";
    homeDirectory = "/home/personal";
    stateVersion  = "22.11";

    packages = defaultPkgs ;

    sessionVariables = {
      DISPLAY = ":0";
      EDITOR = "micro";
    };
  };

  manual = {
    json.enable = false;
    html.enable = false;
    manpages.enable = false;
  };
  news.display = "silent";
}
