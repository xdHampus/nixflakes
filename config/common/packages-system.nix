{ config, lib, pkgs, ... }:

{
  config = {
    environment.systemPackages = with pkgs; [
    (pkgs.writeScriptBin "nixFlakes" ''
      #!/usr/bin/env bash
      exec ${pkgs.nixFlakes}/bin/nix --experimental-features "nix-command flakes" "$@"
    '')

    vim
    git
    wget
    zip
    unzip
    htop
    coreutils
    killall
    usbutils
    ntfs3g
    acpilight
    xterm
    rofi
    pcmanfm
    xmobar

    ];
  };
}
