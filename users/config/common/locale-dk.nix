{ config, lib, pkgs, ... }:

{
  # Timezone
  time.timeZone = "Europe/Amsterdam";

  # Locales
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "dk";
  };
}
