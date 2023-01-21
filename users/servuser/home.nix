{ config, lib, pkgs, stdenv, ... }:

let
  defaultPkgs = with pkgs; [
    binutils-unwrapped
    stow
  ];

in
{
  programs.home-manager.enable = true;
  imports = [] ++ (import ./../../hm/module-list.nix);

  modules = {
    dev.git.github.enable = true;    
    tools = {
      firefox.enable = true;
    };
  };
  


  xdg.enable = true;

  home = {
    username      = "servuser";
    homeDirectory = "/home/servuser";
    stateVersion  = "22.05";

    packages = defaultPkgs;

    sessionVariables = {
      DISPLAY = ":0";
      EDITOR = "nano";
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
