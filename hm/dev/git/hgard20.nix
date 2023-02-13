{ pkgs, lib, config, ... }:
with lib;                      
let
  cfg = config.modules.dev.git.hgard20;
in {
  options.modules.dev.git.hgard20 = {
    enable = mkEnableOption "edu git user";
  };
  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userEmail = "hgard20@student.sdu.dk";
      userName = "hgard20";
      signing = {
        signByDefault = true;
        key = "EC2E1670D8DE49B3585381E443D2C6DA477ADC74";
      };
      extraConfig = {
        safe.directory = "*";
        credential.helper = "libsecret";
      };
    };
  };
}
