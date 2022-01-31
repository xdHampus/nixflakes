{ config, lib, pkgs, stdenv, ... }:

let
  defaultPkgs = with pkgs; [];

in
{
  programs.home-manager.enable = true;
  imports = [] ++ (import ./../../modules/hm/module-list.nix);

  modules = {
    tools = {
      firefox.enable = true;
    };
  };
  
  xdg.enable = true;

  home = {
    username      = "guest";
    homeDirectory = "/home/guest";
    stateVersion  = "21.11";

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
