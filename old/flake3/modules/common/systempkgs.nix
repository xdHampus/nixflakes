{ pkgs, config, ... }:
let
  my-python-packages = python-packages: with python-packages; [
    jedi
    pynvim
    numpy
    pip
    pylint
  ];
  python-with-my-packages = pkgs.unstable.python37.withPackages my-python-packages;
in
{
  environment.systemPackages = with pkgs; [
    wget
    git
    git-crypt
    bat
    sox
    neovim
    nodejs
    yarn
    openssh
    unzip
    gnumake
    #unstable.gcc10
    xorg.xbacklight
    python-with-my-packages
    cachix
    #unstable.ipad_charge
    fish
    home-manager
    flashfocus
    libffi
    xorg.libxcb
  ];
}
