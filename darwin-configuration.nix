{ config, pkgs, ... }:

let 
  keycodes = import ./nix/keycodes.nix;

  nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
    inherit pkgs;
  };

  overlays = self: super: rec {
    openITerm = super.writeScriptBin "openITerm" ''#!/usr/bin/osascript
      tell application "iTerm"
        create window with default profile
      end tell 
      '';

    openNVim = super.writeScriptBin "openNvim" ''#!/usr/bin/osascript
      tell application "iTerm"
        create window with default profile command "/run/current-system/sw/bin/nvim"
      end tell 
      '';
  };
in
  {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [ 
    pkgs.fzf
    pkgs.fd
    pkgs.entr
    pkgs.jq
    pkgs.autojump
    pkgs.bashInteractive
    pkgs.coreutils
    pkgs.gawk
    pkgs.bat
    pkgs.findutils
    pkgs.direnv

    pkgs.curl
    pkgs.wget
    pkgs.guile
    pkgs.runcached
    pkgs.lastpass-cli

    pkgs.neovim
    pkgs.global
    pkgs.ctags
    pkgs.highlight

    pkgs.gitAndTools.gitFull
    pkgs.gist
    pkgs.gitAndTools.hub

    pkgs.awscli
    pkgs.travis

    pkgs.openITerm
    pkgs.openNVim

    pkgs.lzma
    pkgs.ripgrep

    pkgs.weechat
    pkgs.pwgen

    pkgs.gnupg
    pkgs.dhall
    pkgs.gcalcli
    pkgs.todoist

    pkgs.iTerm2
    pkgs.Dash
    pkgs.Docker
    pkgs.Focus

    pkgs.myscripts
    pkgs.yubikey-manager
  ];

  environment.pathsToLink = [
    "/share/vim-plugins"
    "/share/emacs/site-lisp"
    "/share/git"
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 3;

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix.maxJobs = 4;
  nix.buildCores = 8;
  nix.nixPath = [ 
    "darwin=$HOME/.nix-defexpr/channels/darwin"
    "nixpkgs=$HOME/.nix-defexpr/channels/nixpkgs"
    "darwin-config=$HOME/.nixpkgs/darwin-configuration.nix"
    "/nix/var/nix/profiles/per-user/root/channels"
    "nixpkgs-overlays=$HOME/Dotfiles/nix/overlays"
  ];
 
  nixpkgs.overlays = [ 
    overlays
    (import ./nix/overlays/mac)
    (import ./nix/overlays/common)
  ];

  environment.shellAliases = import ./nix/aliases.nix;
  environment.variables = import ./nix/variables.nix;
  environment.loginShell = "/run/current-system/sw/bin/bash";

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.bash.enable = true;
  programs.bash.enableCompletion = true;
  programs.bash.interactiveShellInit = ''
    if [ -f $HOME/.bashrc ]; then
      source $HOME/.bashrc
    fi

    source $(nix-store -r $(which autojump) 2>/dev/null)/etc/profile.d/autojump.sh
  '';

  programs.tmux.enable = true;
  programs.tmux.enableSensible = true;
  programs.tmux.enableFzf = true;
  programs.tmux.enableVim = true;

  fonts = {
    enableFontDir = true;
    fonts = [ pkgs.fira-code pkgs.powerline-fonts pkgs.fonts.pragmatapro-nerd-fonts pkgs.fonts.jetbrains-mono-nerd-fonts ];
  };
}
