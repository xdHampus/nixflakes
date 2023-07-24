{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.services.syncthing;
in {
  options.modules.services.syncthing = {
    enable = mkEnableOption "syncthing";

    code.enable = mkEnableOption "enable";
    code.devices = mkOption {
      type = with types; listOf str;
      default = [ ];
    };

    shared.enable = mkEnableOption "enable";
    shared.devices = mkOption {
      type = with types; listOf str;
      default = [ ];
    };

    vault.enable = mkEnableOption "enable";
    vault.devices = mkOption {
      type = with types; listOf str;
      default = [ ];
    };

  };
  config = mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      openDefaultPorts = true;
      guiAddress = "0.0.0.0:8384";
      overrideDevices = true;
      overrideFolders = true;
      group = "users";
        devices = {
          "hlp" = {
            id =
              "H6F26EV-YRBI2K4-R75PU4B-OFUL4GT-AEAB7ND-CMBFMID-TEHOAJZ-S6D2IAE";
          };
          "hlpw" = {
            id =
              "BMHNMGG-QAPTLVL-CZX4XDJ-HB4X6JQ-A4O44Y5-OWV5YHE-RHEUGWU-R62EDAN";
          };
          "hdesktop" = {
            id =
              "VLCZPQS-BW3U3BD-QERSSJJ-MB23JXT-BSIDVMP-CTUCS2P-KJQ73TN-FXO72AV";
          };
          "hdesktopw" = {
            id =
              "GMTAH6B-AUU7OHL-QM5MRIU-ZFJWGPT-3527EI4-LXLX5LB-EKB5YI5-PZASYAN";
          };
          "moto g30" = {
            id =
              "AJXHYZS-R7GUMX3-4NKPWE7-EGSJ7TX-BLUQPCJ-KRYA6DC-J5DLBYS-CWCZNQ6";
          };
        };

        folders = {
          "code" = mkIf cfg.code.enable {
            path = "/sync/code";
            devices = [ ] ++ cfg.code.devices;
            versioning = {
              type = "staggered";
              params = {
                cleanInterval = "3600";
                maxAge = "15768000";
              };
            };
          };
          "shared" = mkIf cfg.shared.enable {
            path = "/sync/shared";
            devices = [ ] ++ cfg.shared.devices;
            versioning = {
              type = "staggered";
              params = {
                cleanInterval = "3600";
                maxAge = "15768000";
              };
            };
          };
          "vault" = mkIf cfg.vault.enable {
            path = "/sync/vault";
            devices = [ ] ++ cfg.vault.devices;
            versioning = {
              type = "simple";
              params = { keep = "10"; };
            };
          };
        };
    };
  };

}
