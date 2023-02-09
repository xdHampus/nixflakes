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

	#Fonts
	fonts.fonts = with pkgs; [
	  #noto-fonts
	  noto-fonts-cjk
	  #noto-fonts-emoji
	  #liberation_ttf
	  #fira-code
	  #fira-code-symbols
	  #dina-font
	];
	

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
      #font = "Lat2-Terminus16";
      font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
   	  packages = with pkgs; [ terminus_font ];
      keyMap = "dk";
    };
  };
}
