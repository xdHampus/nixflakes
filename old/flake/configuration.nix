# Main NixOS Configuration file

{ config, pkgs, ... }:
  
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Include machine specific configuration.
      #./machines/pc.nix
      ./machines/laptop.nix
      # Include an Xorg configuration
      ./desktops.nix
    ];

  nixpkgs.config.allowUnfree = true;

  # Discord update bypass
  # nixpkgs.overlays = [(self: super: { discord = super.discord.overrideAttrs (_: { src = builtins.fetchTarball <link-to-tarball>; });})];

#flakeflakeflake




  # Bootloader
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
      };
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
        version = 2;
      };
    };
  };



  # Hardware
  hardware = {
    enableRedistributableFirmware = true;
    enableAllFirmware = true;
    cpu.intel.updateMicrocode = true;
    pulseaudio.enable = true;
    pulseaudio.package = pkgs.pulseaudioFull;
    bluetooth.enable = true;
    opengl.enable = true;
    opengl.driSupport = true;
  };

  # Networking
  networking = {
    networkmanager = {
      enable = true;
      packages = [ pkgs.networkmanager_openvpn ];
    };
    useDHCP = false;
    firewall.enable = true;
    firewall.allowPing = true;
  };
  
  # Timezone  
  time.timeZone = "Europe/Amsterdam";

  # Locales
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "dk";
  };

  # Sound
  sound = {
    enable = true;
    mediaKeys.enable = true;
  };
  
  # User accounts
  users.users.hampus = {
    isNormalUser = true;
    home = "/home/hampus";
    description = "Hampus";
    extraGroups = [ "audio" "wheel" "networkmanager" "docker"]; 
  };
  
  # Sudo
  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
  };  

  # Virtualization / other os's support
  virtualisation.virtualbox = {
    host = {
      enable = true;
      enableExtensionPack = true;
    };
    guest.enable = false;
  };
   users.extraGroups.vboxusers.members = [ "hampus" ];
  
  virtualisation.docker = {
    enable = true;
  };
  
  # Basic packages
  environment.systemPackages = with pkgs; [
    (pkgs.writeScriptBin "nixFlakes" ''
      #!/usr/bin/env bash
      exec ${pkgs.nixFlakes}/bin/nix --experimental-features "nix-command flakes" "$@"
    '')




    vim
    git
    wget
    zip
    unzip
    htop
    coreutils
    killall
    usbutils
    ntfs3g
    acpilight
    elinks
    xterm
    firefox
    rofi
    pcmanfm
    xmobar
  
    #dev
    kdevelop	 #c++
    emacs
    cmake #sys
    #social
    discord
    weechat	 #irc
    #notsorted
    ipfs	 #ipfs daemon
    ipget	 #ipfs cli 
    pavucontrol
    jetbrains.idea-ultimate
     jdk
    # vscode
    # pgadmin
    atom
    postgresql
     dbeaver
     #pgmanage
     #pgadmin
      
 ];
  
  # Services
  services = {
      lorri.enable = true;
      printing.enable = true;
      postgresql = {
    	enable = true;
    	package = pkgs.postgresql;
    	enableTCPIP = true;
    	authentication = pkgs.lib.mkOverride 10 ''
      	  local all all trust
      	  host all all ::1/128 trust
    	'';
        initialScript = pkgs.writeText "backend-initScript" ''
      	  CREATE ROLE nixcloud WITH LOGIN PASSWORD 'nixcloud' CREATEDB;
      	  CREATE DATABASE nixcloud;
      	  GRANT ALL PRIVILEGES ON DATABASE nixcloud TO nixcloud;
    	'';
       };
  };


  
  # Nix config
  nix = {
    autoOptimiseStore = true;

    package = pkgs.nixFlakes; #flake


    # Automate garbage collection
    gc = {
      automatic = true;
      dates     = "weekly";
      options   = "--delete-older-than 7d";
    };

    # Avoid unwanted garbage collection when using nix-direnv
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs     = true
      keep-derivations = true
      builders-use-substitutes = true #flake
    '';


    allowedUsers = [ "hampus" "@wheel" ];
    # Required by Cachix to be used as non-root user
    trustedUsers = [ "root" "hampus" "@wheel"  ];
  };



  system.stateVersion = "21.05"; 

}

