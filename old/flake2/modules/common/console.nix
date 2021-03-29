{ pkgs, ... }:
{  
console = {
    packages = with pkgs; [ unstable.spleen ];
    font = "Lat2-Terminus16";
    keyMap = "dk";
  };
}
