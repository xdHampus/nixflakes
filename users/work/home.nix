{ config, lib, pkgs, stdenv, ... }:

let
  extraPkgs = with pkgs; [
  
  ];

in
{
  programs.home-manager.enable = true;
  imports = [] ++ (import ./../../modules/hm/module-list.nix);

  modules = {
    core = {
      communication.enable = true;
    };
    dev = {
      git.github.enable = true;
      vscode.enable = true;
      profiles = {
        java.enable = true;
        rest.enable = true;
        kube.enable = true;
      };
    };
    system.keepassxc.enable = true;
    tools = {
      firefox.enable = true;
      alacritty.basic.enable = true;
      micro.enable = true;
      zathura.enable = true;
    };
  };
  

  xdg.enable = true;

  home = {
    username      = "work";
    homeDirectory = "/home/work";
    stateVersion  = "22.05";

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
