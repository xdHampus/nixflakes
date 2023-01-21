{ pkgs, lib, config, ... }:
with lib;                      
let
  cfg = config.modules.dev.profiles.csharp;
in {
  options.modules.dev.profiles.csharp = {
    enable = mkEnableOption "csharp";
  };
  config = mkIf cfg.enable {
    home.packages =  with pkgs; [
      # Tools
      micro
      vscode
      vscode-extensions.ms-dotnettools.csharp      
      #Deps
      dotnet-sdk_5
      dotnetCorePackages.sdk_3_1
      dotnetCorePackages.runtime_5_0
      #Packaging
      nuget-to-nix
    ];
  };
}
