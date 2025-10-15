{ pkgs, lib, config, ... }:
with lib;
let
  themeColors = {
    background = "#282c34";
    borderPrimary = "#5c6370";
    borderSecondary = "#5f676a";
    indicator = "#484e50";
    text = "#abb2bf";
  };
  cfg = config.modules.system.i3;
in {
  options.modules.system.i3 = { enable = mkEnableOption "i3"; };
  config = mkIf cfg.enable {
    services.picom = {
      enable = true;
      fadeExclude =
        [ "name ~= 'Firefox$'" "name ~= 'firefox$'" "name ~= 'discord$'" ];
    };

    xsession = {
      enable = true;

      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
        config = {
          floating.titlebar = false;
          colors = {
            focused = {
              background = themeColors.background;
              border = themeColors.borderPrimary;
              childBorder = themeColors.borderSecondary;
              indicator = themeColors.indicator;
              text = themeColors.text;
            };
            focusedInactive = {
              background = themeColors.background;
              border = themeColors.borderPrimary;
              childBorder = themeColors.borderSecondary;
              indicator = themeColors.indicator;
              text = themeColors.text;
            };
            unfocused = {
              background = themeColors.background;
              border = themeColors.borderPrimary;
              childBorder = themeColors.borderSecondary;
              indicator = themeColors.indicator;
              text = themeColors.text;
            };

          };
          gaps = {
            outer = 5;
            inner = 5;
          };
          window.commands = [{
            command = "border pixel 1";
            criteria = { all = true; };
          }];
          keybindings =
            let modifier = config.xsession.windowManager.i3.config.modifier;
            in lib.mkOptionDefault {
              "${modifier}+Return" = "exec alacritty";
              "--release ${modifier}+Shift+s" =
                "exec scrot -fs  /sync/pictures/Screenshots/%Y-%m-%d_$wx$h_scrot.png'";
            };
          menu = "rofi -show drun";
          modifier = "Mod1";
          terminal = "alacritty";
          startup = [
            {
              command =
                "xrandr --output DVI-D-0 --auto --left-of HDMI-0 --output HDMI-0 --auto --primary --left-of VGA-0 --output VGA-0 --auto";
              notification = false;
            }
            {
              command = "picom";
              always = true;
              notification = false;
            }
            {
              command =
                " feh --bg-fill ~/.config/wallpapers/left.png --bg-fill ~/.config/wallpapers/right.png --bg-fill ~/.config/wallpapers/center.png";
              always = true;
              notification = false;
            }
          ];
        };
      };
    };
  };
}
