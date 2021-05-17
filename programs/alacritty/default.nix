{ fontSize, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      background_opacity = 0.85;
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
        decorations = "full";
        padding = {
          x = 5;
          y = 5;
        };
      };
    };
  };
}
