{ config, lib, pkgs, stdenv, ... }:


let
  extraPkgs = with pkgs; [
    micro
    chromium
    jetbrains.rider
  ];

in
{
  programs.home-manager.enable = true;
  imports = [] ++ (import ./../../hm/module-list.nix);

  modules = {
    dev = {
      git.hgard20.enable = true;
      #vscode.enable = true;
      profiles = {
        java.enable = true;
      };
    };
    system.keepassxc.enable = true;
    tools = {
      firefox.enable = true;
      alacritty.basic.enable = true;
      #micro.enable = true;
      zathura.enable = true;
    };
  };
  

  xdg.enable = true;

  home = {
    username      = "work";
    homeDirectory = "/home/work";
    stateVersion  = "23.05";

    packages = extraPkgs ;

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
