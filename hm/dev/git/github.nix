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
      signing = {
        signByDefault = true;
        key = "92E64A58CB991439E65E55808BF11BFB786AC2C1";
      };
      extraConfig = {
        safe.directory = "*";
        credential.helper = "libsecret";
      };
    };
  };
}
