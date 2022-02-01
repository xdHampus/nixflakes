{ config, lib, pkgs, stdenv, ... }:

let
  defaultPkgs = with pkgs; [
    binutils-unwrapped
    stow
  	xclip
  	feh
  	scrot
	rofi	
  ];
in
{

  imports = [ ] ++ (import ./../../modules/hm/module-list.nix);

  # Define modules
  modules = 
  		{
        core = {
          communication.enable = true;
        };
        system = {
          i3.enable = true;
        };
        dev = {
          git.github.enable = true;
          vscode.enable = true;
          profiles = {
            java.enable = true;
            rest.enable = true;
          };
        };
        tools = {
          firefox.enable = true;
          alacritty.default.enable = true;
          micro.enable = true;
        };  		  
  		};
  

  programs.home-manager.enable =  true;
  xdg.enable = true;

  xdg.configFile =  {
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
    stateVersion  = "21.11";

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

  # notifications about home-manager news
  news.display = "silent";

}
