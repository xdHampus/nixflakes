{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.common.packages;
in {
  options.modules.common.packages = {
    enable = mkEnableOption "packages";
  };
  config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        (pkgs.writeScriptBin "nixFlakes" ''
          #!/usr/bin/env bash
          exec ${pkgs.nixFlakes}/bin/nix --experimental-features "nix-command flakes" "$@"
        '')

        vim
        gitFull
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
        pcmanfm
        micro
        xclip
      ];
  };
}
