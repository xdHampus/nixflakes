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
    unstable.neovim
    unstable.nodejs
    unstable.yarn
    unstable.openssh
    unzip
    unstable.gnumake
    unstable.gcc10
    unstable.xorg.xbacklight
    python-with-my-packages
    cachix
    unstable.ipad_charge
    unstable.fish
    home-manager
    unstable.flashfocus
    libffi
    xorg.libxcb
  ];
}
