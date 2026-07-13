{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  #boot.loader.grub.device = nodev;
  #boot.loader.grub.efiSupport = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # networking.hostName = "nixos"; # Define your hostname.

  # some packages like Obsidian
  nixpkgs.config.allowUnfree = true; 

  # tryout for dark themes
  # TODO: not working
  programs.dconf.enable = true;
  programs.dconf.profiles.user.databases = [{
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  }];

  # vim as default
  programs.vim = {
    enable = true;
    defaultEditor = true;
  };

  # shell aliases
  environment.shellAliases = {
    l = "ls -lhX --group-directories-first";
    ll = "ls -lhXA --group-directories-first";
    zz = "exit";
    qq = "ps -eo pid,command | grep";
    ".." = "cd .. && l";
  };

  boot.supportedFilesystems = [ "ntfs" ];
  services.gvfs.enable = true;
  services.udisks2.enable = true;


  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Samara";

  # set auto update
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    windowManager.qtile = {
        enable = true;
    };
  };

  # sound
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.timur = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;

  # --------------
  # -- PACKAGES --
  # --------------

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    yazi
    qimgv
    papers
    git
    github-cli
    dysk
    fastfetch
    tmux
    pavucontrol
    kitty
    python313Packages.qtile
    brightnessctl
    obsidian
    thunar
    btop
    nvtopPackages.full
    keepassxc
    vlc
    libreoffice
  ];


  # --------------
  # -- VERSION  --
  # --------------

  system.stateVersion = "26.05";

}

