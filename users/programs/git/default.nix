{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userEmail = "16954508+xdHampus@users.noreply.github.com";
    userName = "xdHampus";
    extraConfig = {
      credential.helper = "libsecret";
    };
  };
}
