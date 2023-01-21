{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.common.locale.dk;
in {
  options.modules.common.locale.dk = {
    enable = mkEnableOption "locale-dk";
  };
  config = mkIf cfg.enable {
    # Timezone
    time.timeZone = "Europe/Amsterdam";

    # Locales
    i18n.defaultLocale = "en_US.UTF-8";
    console = {
      font = "Lat2-Terminus16";
      keyMap = "dk";
    };
  };
}
