{ config, pkgs, tmux-config, vim-config, ... }:

{
    home.username = "timur";
    home.homeDirectory = "/home/timur";

    home.packages = [];

    programs.git.settings = {
        enable = true;
        user.name = "Timur Shamsrakhmanov";
        user.email = "tshamsrakhmanov@gmail.com";

        alias = {
            st = "status -sb";
            lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
            cm = "commit -m";
        };

    };

    home.file = {
        ".tmux.conf".source = "${tmux-config}/.tmux.conf";
        ".vimrc".source = "${vim-config}/.vimrc";
    };


    programs.bash = {
        enable = true;
        enableCompletion = true;
        shellAliases = {
            l = "eza -l --color=always --group-directories-first --icons";
            ll = "eza -al --color=always --group-directories-first --icons";
            zz = "exit";
            qq = "ps -eo pid,command | grep";
            update = "sudo nixos-rebuild switch --flake .";
            ".." = "cd .. && l";
        };
    };

# Minimal configuration to test
    home.stateVersion = "26.05";
}
