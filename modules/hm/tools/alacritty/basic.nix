{ lib, config, fontSize, pkgs, ... }:
with lib;                      
let
  cfg = config.modules.tools.alacritty.basic;
in {

  options.modules.tools.alacritty.basic = {
    enable = mkEnableOption "alacritty basic";
  };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        bell = {
          animation = "EaseOutExpo";
          duration = 5;
          color = "#ffffff";
        };
        selection.save_to_clipboard = true;
        window = {
          decorations = "full";
          padding = {
            x = 5;
            y = 5;
          };
        };
      };
    };
  };
}
