{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.services.githubrunner;
in {
  options.modules.services.githubrunner = {
    enable = mkEnableOption "githubrunner";
    url = mkOption { type = types.str; default = ""; };
    tokenFile = mkOption { type = types.str; default = ""; };
  };
  config = mkIf cfg.enable {
    services.github-runner = {
          enable = true;
          url = cfg.url;
          tokenFile = cfg.tokenFile;          
    };
  };
}
