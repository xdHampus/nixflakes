{ config, lib, pkgs, stdenv, ... }:

let
  defaultPkgs = with pkgs; [
    # fixes the `ar` error required by cabal
    binutils-unwrapped
    stow
  ];

  gitPkgs = with pkgs.gitAndTools; [
  ];

  haskellPkgs = with pkgs.haskellPackages; [
    nix-tree                # visualize nix dependencies
  ];

  xmonadPkgs = with pkgs; [
    xorg.xkbcomp           # keymaps modifier
    xorg.xmodmap           # keymaps modifier
    xorg.xrandr            # display manager (X Resize and Rotate protocol)
  ];

in
{
  programs.home-manager.enable = true;

  imports = [
    ./../../programs/firefox/default.nix
    #./../../programs/xmonad/default.nix
    ./../../programs/alacritty/default.nix
    ./../../programs/git/default.nix
    ./../../programs/vscode/default.nix
    #./../../programs/gnome-keyring/default.nix
    ./../../config/services/xscreensaver.nix    
  ];

  xdg.enable = true;

  home = {
    username      = "hamtest";
    homeDirectory = "/home/hamtest";
    stateVersion  = "21.11";

    packages = defaultPkgs ++ gitPkgs ++ haskellPkgs ++ xmonadPkgs ;

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
