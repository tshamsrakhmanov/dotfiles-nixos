{ config, pkgs, ... }:

{

  # ------------------
  # -- BOOT LOADER  --
  # ------------------
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # --------------
  # -- KERNEL   --
  # --------------
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # --------------
  # -- UNFREE   --
  # --------------
  nixpkgs.config.allowUnfree = true; 

  # -------------------------
  # -- DARK THEME FOR KDE  --
  # -------------------------
  # FIXME
  programs.dconf.enable = true;
  programs.dconf.profiles.user.databases = [{
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  }];


  # ---------------------
  # -- NTFS AUTOMOUNT  --
  # ---------------------
  boot.supportedFilesystems = [ "ntfs" ];
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  # access rights for thunar
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if ((action.id == "org.freedesktop.udisks2.filesystem-mount-system" ||
           action.id == "org.freedesktop.udisks2.filesystem-mount") &&
          subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';

  # --------------
  # -- NETWORK  --
  # --------------
  networking.networkmanager.enable = true;

  # --------------
  # -- TIMEZONE --
  # --------------
  time.timeZone = "Europe/Samara";

  # --------------
  # -- AUTO UPD --
  # --------------
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  # --------------
  # -- LOCALE   --
  # --------------
  i18n.defaultLocale = "en_US.UTF-8";

  # -----------------------
  # -- WINDOW MANAGER    --
  # -----------------------
  services.xserver = {
    enable = true;
    windowManager.qtile = {
        enable = true;
    };
  };

  # --------------
  # -- SOUND    --
  # --------------
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # --------------
  # -- VERSION  --
  # --------------

  system.stateVersion = "26.05";

}
