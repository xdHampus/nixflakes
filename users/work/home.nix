{ config, lib, pkgs, stdenv, ... }:

let
  defaultPkgs = with pkgs; [
    micro
    firefox
    alacritty
    python3Full
    zathura
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
	kubernetes
	kubectl
  ];

in
{
  programs.home-manager.enable = true;
  imports = [
  ] 
    ++  (import ./../../modules/hm/module-list.nix)
  ;

  modules.tools.firefox.enable = true;
  modules.dev.git.github.enable = true;
  modules.dev.vscode.enable = true;

  xdg.enable = true;

  home = {
    username      = "work";
    homeDirectory = "/home/work";
    stateVersion  = "22.05";

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
  news.display = "silent";
}
