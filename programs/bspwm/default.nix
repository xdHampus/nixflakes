{ pkgs, ...}:

let
in
{
  
  xsession = {
    enable = true;

    windowManager.bspwm = {
      enable = true;
      settings = {
	border_width = 2;
	focus_follows_pointer = true;
	window_gap = 3;
     };
    };
  };
}
