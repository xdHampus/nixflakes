{ config, lib, pkgs, stdenv, ... }:

let
  defaultPkgs = with pkgs; [
    # fixes the `ar` error required by cabal
    binutils-unwrapped
    stow
    micro
	xclip
	feh
	scrot
	vivaldi
  ];

  gitPkgs = with pkgs.gitAndTools; [
  ];

in
{
  programs.home-manager.enable = true;

  imports = [
    ./../../programs/firefox/default.nix
    ./../../programs/i3/default.nix
    ./../../programs/alacritty/default.nix
    ./../../programs/git/default.nix
    ./../../programs/vscode/default.nix
	./../../programs/micro/default.nix
    #./../../programs/gnome-keyring/default.nix
  ];

  xdg.enable = true;

  xdg.configFile = {
  	nvidiaSettings = {
  		source = ./files/.nvidia-settings-rc;
  		target = "./../.nvidia-settings-rc";
  	};
  	leftWallpaper = {
  		source = ./files/bg/33.png;
  		target = "./wallpapers/left.png";
  	};
  	centerWallpaper = {
  		source = ./files/bg/34.png;
  		target = "./wallpapers/center.png";
  	};
  	rightWallpaper = {
  		source = ./files/bg/37.png;
  		target = "./wallpapers/right.png";
  	};
  };

  home = {
    username      = "hadmin";
    homeDirectory = "/home/hadmin";
    stateVersion  = "21.05";

    packages = defaultPkgs ++ gitPkgs ;

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
