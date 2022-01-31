{ pkgs, lib, config, ... }:
with lib;                      
let
  cfg = config.modules.dev.profiles.cpp;
in {
  options.modules.dev.profiles.cpp = {
    enable = mkEnableOption "cpp";
  };
  config = mkIf cfg.enable {
    home.packages =  with pkgs; [
      # Development Tools
      llvmPackages_11.clang
      cmake
      cmakeCurses
      gitFull # cmake FetchContent
      jetbrains.clion
      # Development time dependencies
      gtest
    ];
  };
}
