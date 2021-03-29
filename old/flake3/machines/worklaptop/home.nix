{ config, pkgs, lib, ... }:
let
  haskell-env = pkgs.unstable.haskellPackages.ghcWithHoogle (
    hp: with hp; [
      xmonad
      xmonad-contrib
      xmonad-extras
      apply-refact
      haskell-language-server
      brittany
      cabal-install
      hlint
      xmobar
    ]
  );

in
{
  home.packages = with pkgs; [
    haskell-env
    clinfo
    radeontop
    radeon-profile
    cpu-x
    trash-cli
    tree
    bc
    gitAndTools.diff-so-fancy
    gitAndTools.delta
    unstable.ripgrep
    unstable.fd
    unstable.fzf
    unstable.mosh
    binutils
    killall
    neofetch
    pfetch
    nodePackages.node2nix
    cabal2nix
    nix-index
    niv
    rnix-lsp
    scrot
    feh
    tty-clock
    appimage-run
    lightlocker
    circleci-cli
    fontforge
    palenight-gtk-theme
    unstable.pop-icon-theme
    unstable.hicolor-icon-theme # fallback gtk theme
    unstable.pandoc
    unstable.nitrogen
    unstable.chafa
    unstable.ueberzug
    # nixpkgs
    nixfmt
    nixpkgs-fmt
    nixpkgs-review
    nix-prefetch-git
    nix-prefetch-github
    pypi2nix
    # rust
    unstable.cargo
    # lua
    unstable.luajit
    unstable.luajitPackages.lua-lsp
    # tui apps
    cava
    unstable.vifm-full
    vifmimg
    htop
    unstable.bottom
    ncpamixer
    unstable.mps-youtube
    unstable.lazygit
    # gui apps
  #  gimp
    #krita
    #kdenlive
   #olive-editor
    #blender
    #master.discord
    tdesktop
    pavucontrol
#    spotify
    #sxiv
    #unstable.steam
    #unstable.multimc
    #nur.repos.ivar.yuzu-ea
    #nur.repos.ivar.ryujinx
    unstable.virt-manager
    unstable.pulseeffects-legacy
    unstable.corectrl
#    (unstable.kodiPlugins.kodiWithPlugins (pkgs: with pkgs; [
#      unstable.kodiPlugins.joystick
#      unstable.kodiPlugins.inputstream-adaptive
#      unstable.kodiPlugins.vfs-libarchive
#      (unstable.pythonPackages.pillow // { extraRuntimeDependencies = []; })
#      (unstable.python3Packages.python // { extraRuntimeDependencies = []; })
#    ]))
    # node packages
    nodePackages.gitmoji-cli
    # dependencies
    ffmpeg-full
    unstable.ffmpegthumbnailer
    frei0r
    unstable.universal-ctags
    libnotify
    xsel # used by xmonad emoji prompt
    unstable.youtube-dl
    unstable.neovim-remote
    unstable.direnv
    unstable.imagemagick
    unstable.zstd
    unstable.editorconfig-core-c
    unstable.sqlite
    unstable.shairplay
    # misc
    glxinfo
    xclip
    qt5.qttools
    xkb-switch
    unstable.libinput-gestures
    unstable.xdotool
    unstable.devour
    unstable.xorg.xwininfo
    unstable.xfontsel
    unstable.xorg.libXext
    #unstable.steam-run
    xorg.xev
    file
    catimg
    # joke command
    cowsay
    cmatrix
    espeak
    figlet
    fortune
    asciiquarium

    #TEST
    weechat
    atom
    
  ];

  #services.lorri.enable = true; # WARNING in /modules/common/services.nix instead
  services.keynav.enable = true;

  programs = {
    home-manager.enable = true;
    neovim = (import ../../modules/editors/neovim.nix) { inherit pkgs; };
  };


  home.keyboard = {
    layout = "dk";
  };
  
  xsession.profileExtra = "xrandr --output DVI-D-0 --scale-from 2560x1440 --panning 2560x1440";

  home.file = {

    ".xmonad/xmobar.hs".source = ../../haskell/xmobar.hs;
    ".xmonad/xmobar.hs".onChange = ''
      if [[ -v DISPLAY ]] ; then
          echo "Recompiling xmobar"
          xmobar -r ~/.xmonad/xmobar.hs &
          sleep 2
          disown
          killall xmobar
          echo "Restarting"
          xmonad --restart
      fi
    ''; 

    # tmux theme
#    ".palenight-tmux".source = ../../.palenight-tmux;

    # neovim dashboard logo
#    "Pictures/neovimlogo.png".source = (pkgs.fetchurl {
#      url = "https://raw.githubusercontent.com/neovim/neovim.github.io/master/logos/neovim-logo-flat.png";
#      sha256 = "1vl7mi87wisqhd9zigg24y2ksjyyjk6225bvw9qk4s6gfv62w4jm";
#    });

    # emacs-anywhere
#    ".emacs_anywhere".source = (pkgs.fetchFromGitHub {
#      owner = "btwiusegentoo";
#      repo = "emacs-anywhere";
#      rev = "e739c8bf1930eeb68ecaf312a885f5788942154c";
#      sha256 = "0k0iay6pd01k2nyjm2n648n8ja36mgarvb9677ky2d758xkzgckv";
#    });

    # doom emacs
  #  ".doom.d/init.el".source = ../../doom.d/init.el;
  #  ".doom.d/config.el".source = ../../doom.d/config.el;
   # ".doom.d/packages.el".source = ../../doom.d/packages.el;

   # ".ghc/ghci.conf".text = ''
   #   :set prompt "%s λ: "
   # '';

  };

  xsession = {
    enable = true;
    scriptPath = ".hm-xsession";

    pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "bibata-cursors";
      size = 16;
    };

  }; 

  xresources.properties = {
    "Xft.dpi" = 96;
  };


  # Home Manager needs a bit of information about you and the
  # paths it should manage.

 #home = mkDefault {
       home.username = "hamkek";
       home.homeDirectory = "/home/hamkek";
  #};
#  home.username = "ham";
 # home.homeDirectory = mkDefault {
#	 "/home/ham"
  # };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";


  home.sessionVariables = {
    "XDG_CONFIG_HOME" = "$HOME/.config";
    "MANPAGER" = "sh -c 'col -bx | bat -l man -p'";
    "COLORTERM" = "truecolor";
    "THEOS" = "$HOME/theos";
  };

}
