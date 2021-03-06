{ pkgs, lib, config, ... }:
with lib;                      
let
  cfg = config.modules.dev.vscode;
in {
  options.modules.dev.vscode = {
    enable = mkEnableOption "vscode";
  };
  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;
      #extensions = with pkgs.vscode-extensions; [
        # Language support
        #bbenoist.Nix
        #jebbs.plantuml
        #justusadam.language-haskell
        #ms-python.python
        #ms-vscode.cpptools-extension-pack
        #vscjava.vscode-java-pack

        # Tools
        #MS-vsliveshare.vsliveshare
        #MS-vsliveshare.vsliveshare-pack #preview pack
        #esbenp.prettier-vscode
      #];
    };
  };
}
