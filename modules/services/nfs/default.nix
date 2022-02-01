{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.services.nfs;
in {
  options.modules.services.nfs = {
    enable = mkEnableOption "nfs";
  };
  config = mkIf cfg.enable {
    services.nfs.server = {
      enable = true;
  		exports = ''
  			/storage/Music/Library 192.168.1.0/24(rw,sync)
  		'';
    };
  };
}
