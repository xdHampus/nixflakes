{ lib, config, fontSize, pkgs, ... }:
with lib;                      
let
  cfg = config.modules.tools.alacritty.default;
in {

  options.modules.tools.alacritty.default = {
    enable = mkEnableOption "alacritty default";
  };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        window.opacity = 0.85;
        bell = {
          animation = "EaseOutExpo";
          duration = 5;
          color = "#ffffff";
        };
        colors = {
          primary = {
            background = "#282c34";
            foreground = "#abb2bf";
          };
        };
        font = {
          normal = {
            #family = "JetBrainsMono Nerd Font";
            style = "Regular";
          };
          size = 9;
        };
        selection.save_to_clipboard = true;
        #shell.program = "${pkgs.fish}/bin/fish";
        window = {
          opacity = 0.85;
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
