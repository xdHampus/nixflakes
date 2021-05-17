{ config, lib, pkgs, stdenv, ... }:

let
  defaultPkgs = with pkgs; [
    # fixes the `ar` error required by cabal
    binutils-unwrapped
    stow
  ];

  gitPkgs = with pkgs.gitAndTools; [
  ];

in
{
  programs.home-manager.enable = true;

  imports = [
    ./../../programs/firefox/default.nix
    ./../../programs/xmonad/default.nix
    ./../../programs/alacritty/default.nix
    ./../../programs/git/default.nix
  ];

  xdg.enable = true;

  home = {
    username      = "servuser";
    homeDirectory = "/home/servuser";
    stateVersion  = "21.05";

    packages = defaultPkgs ++ gitPkgs;

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
