# Main NixOS Configuration file

{ config, pkgs, nixpkgs-unstable, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ] ++ (import ./../../modules/module-list.nix);

  nixpkgs.config.allowUnfree = true;

  modules = {
    common = {
      # Machine
      boot.uefi.enable = true;
      hardware.enable = true;
      de.nonei3.enable = true;
      # Misc
      nix.enable = true;
      security.enable = true;
      services.enable = true;
      #sound.enable = true; 
      packages.enable = true;
      locale.dk.enable = true;
    };
    # Users
    users = {
      personal.enable = true;
      work.enable = true;
    };
    # Misc
    virtualisation.docker.enable = true;
    virtualisation.virtualbox.enable = true;
    services = {
      mpd.client.enable = true;
      mpd.client.host.port = "2049";
      borgbackup.personal.main.enable = true;
      teamviewer.enable = true;
      syncthing = {
        enable = true;
        vault = {
          enable = true;
          devices = [
            "moto g30"
            "hlp"
            "hlpw"
          ];
        };
        code = {
          enable = true;
          devices = [
            "hlp"
            "hlpw"
          ];
        };
        shared = {
          enable = true;
          devices = [
            "hlp"
            "hlpw"
          ];
        };
      };
    };
  };


  # Remove sound.enable or turn it off if you had it set previously, it seems to cause conflicts with pipewire
  sound.enable = false;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
  };


  programs.steam.enable = true;
  # Machine specific Xorg settings, mainly drivers
  services.xserver = {
    videoDrivers = [
      "nvidia"
    ];
    # Fix mouse issue
    config = ''
      Section "InputClass"
              Identifier     "Mouse Remap"
               MatchProduct   "Mad Catz Mad Catz R.A.T.TE"
              MatchDevicePath "/dev/input/event*"
              Option         "ButtonMapping" " 1 2 3 4 5 6 7 8 9 10 11 12 0 0 0"
              Option        "ZAxisMapping" "4 5 6 7"
      EndSection      
    '';
  };
  hardware.nvidia = {
    modesetting.enable = true;
  };

  # Networking
  networking = {
    hostName = "hdesktop";
    networkmanager = {
      enable = true;
      plugins = [ pkgs.networkmanager-openvpn ];
    };
    useDHCP = false;
    firewall = {
      enable = true;
      allowPing = true;
    };
  };

  # Multi monitor, also configured per user
  # due to issues with nvidia
  services.xserver.xrandrHeads = [
    {
      output = "DVI-D-0";
      primary = false;
      monitorConfig = "Option \"Left-off\" \"HDMI-0\"";
    }
    {
      output = "HDMI-0";
      primary = true;
      monitorConfig = "Option \"Left-off\" \"VGA-0\"";
    }
    {
      output = "VGA-0";
      primary = false;
    }
  ];

  # Basic packages
  environment.systemPackages = with pkgs; [
    sxhkd
    weechat
    pavucontrol
    keepassxc
    atom
    pgweb
    borgbackup
    ncmpcpp
    nixpkgs-unstable.discord
  ];

  system.stateVersion = "23.05";
}
