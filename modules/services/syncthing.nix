{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.services.syncthing;
in {
  options.modules.services.syncthing = {
    enable = mkEnableOption "syncthing";

    code.enable = mkEnableOption "enable";
    code.devices = mkOption {
      type = with types; listOf str;
      default = [
        "hlp"
        "hdesktop"
      ];
    };
    shared.enable = mkEnableOption "enable";
    shared.devices = mkOption {
      type = with types; listOf str;
      default = [
        "hlp"
        "hdesktop"
      ];
    };
    vault.enable = mkEnableOption "enable";
    vault.devices = mkOption {
      type = with types; listOf str;
      default = [
        "hlp"
        "hdesktop"
        "moto g(30)"
      ];
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
        "hlp" = { id = "S4JMUKW-GUHMAKS-NEEBELD-2D7JKCS-FEGHQH6-PFGBS5R-Z3UDW5B-7EHGMAV"; };
        "hdesktopw" = { id = "GMTAH6B-AUU7OHL-QM5MRIU-ZFJWGPT-3527EI4-LXLX5LB-EKB5YI5-PZASYAN"; };
        "moto g(30)" = { id = "AJXHYZS-R7GUMX3-4NKPWE7-EGSJ7TX-BLUQPCJ-KRYA6DC-J5DLBYS-CWCZNQ6"; };
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
