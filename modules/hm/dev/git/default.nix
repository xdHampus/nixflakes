{ pkgs, lib, config, ... }:
with lib;                      
let
  cfg = config.modules.dev.git.github;
in {
  options.modules.dev.git.github = {
    enable = mkEnableOption "git for github";
  };
  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userEmail = "16954508+xdHampus@users.noreply.github.com";
      userName = "xdHampus";
      extraConfig = {
        credential.helper = "libsecret";
      };
    };
  };
}
