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
    i18n = {
    	defaultLocale = "en_US.UTF-8";

#		inputMethod.enabled = "ibus";
#		inputMethod.ibus.engines = with pkgs.ibus-engines; [ libpinyin ];

#		inputMethod.enabled = "fcitx";
#		inputMethod.fcitx.engines = with pkgs.fcitx-engines; [ libpinyin ];
    	inputMethod = {
    		enabled = "fcitx5";	
    		fcitx5.addons = [ pkgs.fcitx5-chinese-addons ];
    	};
	};
    console = {
      font = "Lat2-Terminus16";
      keyMap = "dk";
    };
  };
}
