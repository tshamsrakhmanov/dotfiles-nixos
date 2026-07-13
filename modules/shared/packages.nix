{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    wget
    yazi
    git
    github-cli
    dysk 
    fastfetch
    tmux
    qimgv
    papers
    pavucontrol
    kitty
    python313Packages.qtile
    brightnessctl
    obsidian
    thunar
    btop
    nvtopPackages.full
    keepassxc
    eza
    vlc
    libreoffice
    # access rights for thunar
    polkit_gnome
    gvfs
  ];
}
