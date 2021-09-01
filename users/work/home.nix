{ config, lib, pkgs, stdenv, ... }:

let
  defaultPkgs = with pkgs; [
    micro
    firefox
    alacritty
  ];

  gitPkgs = with pkgs.gitAndTools; [
  
  ];


  socialPkgs = with pkgs; [
  	discord
  	teams
  	zoom-us
  ];


  devPkgs = with pkgs; [
	jetbrains.idea-ultimate
  ];

in
{
  programs.home-manager.enable = true;

  imports = [
    ./../../programs/firefox/default.nix
    #./../../programs/alacritty/default.nix
    ./../../programs/git/default.nix
    ./../../programs/vscode/default.nix
    ./../../config/services/xscreensaver.nix
    ./../../config/virtualisation/docker.nix
  ];

  xdg.enable = true;

  home = {
    username      = "work";
    homeDirectory = "/home/work";
    stateVersion  = "21.05";

    packages = defaultPkgs ++ gitPkgs ++ devPkgs ++ socialPkgs ;

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
