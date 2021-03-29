{ config, pkgs, ... }:

let
  gitConfig = {
  };
in
{
  programs.git = {
    enable = true;
    extraConfig = gitConfig;
    userEmail = "16954508+xdHampus@users.noreply.github.com";
    userName = "Hampus";
  };
}
