{ pkgs, ... }:
{
  services.picom.enable = true;
  services.picom.package = pkgs.nur.repos.reedrw.picom-next-ibhagwan;
  services.picom.backend = "glx";
  services.picom.experimentalBackends = true;
  services.picom.opacityRule = [
      "80:class_g  = 'Zathura'"
      "80:class_g  = 'TelegramDesktop'"
      "80:class_g  = 'Discord'"
      "80:class_g  = 'Emacs'"
      "100:class_g = 'keynav'"
  ];
  services.picom.extraOptions = ''
    detect-client-opacity = true;
    detect-rounded-corners = true;
    blur:
    {
        method = "kawase";
        strength = 8;
        background = false;
        background-frame = false;
        background-fixed = false;
    };
    blur-background-exclude = [
        "class_g = 'keynav'"
    ];
    corner-radius = 18;
    rounded-corners-exclude = [
        "window_type = 'dock'",
        "_NET_WM_STATE@:32a *= '_NET_WM_STATE_FULLSCREEN'",
        "class_g = 'keynav'",
    ];
    round-borders = 1;
    round-borders-exclude = [
        "class_g = 'keynav'"
    ];
  '';
}
