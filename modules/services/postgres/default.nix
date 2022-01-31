{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.services.postgres;
in {
  options.modules.services.postgres = {
    enable = mkEnableOption "postgres";
  };
  config = mkIf cfg.enable {
    services.postgresql = {
      	enable = true;
      	package = pkgs.postgresql_13;
      	enableTCPIP = true;
      	authentication = pkgs.lib.mkOverride 10 ''
  	      	local all all trust
  			host all all 127.0.0.1/32 trust
        	 	host all all ::1/128 trust
      	'';
          initialScript = pkgs.writeText "backend-initScript" ''
  		  CREATE ROLE postgres WITH LOGIN PASSWORD 'postgres' CREATEDB;
        	  CREATE ROLE nixcloud WITH LOGIN PASSWORD 'nixcloud' CREATEDB;
        	  CREATE DATABASE nixcloud;
        	  GRANT ALL PRIVILEGES ON DATABASE nixcloud TO nixcloud;
        	  GRANT ALL PRIVILEGES ON DATABASE postgres TO postgres;
      	'';
    };
  };
}
