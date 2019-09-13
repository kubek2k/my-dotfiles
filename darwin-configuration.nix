{ config, pkgs, ... }:

let 
  keycodes = import ./nix/keycodes.nix;

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

  all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};

  cachix = (import (fetchTarball "https://cachix.org/api/v1/install") {}).cachix;
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
    pkgs.ag

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
    cachix
    (all-hies.selection { selector = p: { inherit (p) ghc844 ghc864; }; })
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
    "darwin=$HOME/.nix-defexpr/darwin"
    "darwin-config=$HOME/.nixpkgs/darwin-configuration.nix"
    "/nix/var/nix/profiles/per-user/root/channels"
    "nixpkgs-overlays=$HOME/Dotfiles/nix/overlays"
  ];
 
  nixpkgs.overlays = [ 
    overlays
    (import ./nix/overlays/mac)
    (import ./nix/overlays/common)
  ];

  services.chunkwm.enable = true;
  services.chunkwm.package = pkgs.chunkwm.core;
  services.chunkwm.plugins.list = [ "ffm" "tiling" ];
  services.chunkwm.plugins.dir = "/run/current-system/sw/bin/chunkwm-plugins/";
  services.chunkwm.plugins."tiling".config = ''
    chunkc set desktop_padding_step_size     0
    chunkc set desktop_gap_step_size         0
    chunkc set global_desktop_offset_top     0
    chunkc set global_desktop_offset_bottom  0
    chunkc set global_desktop_offset_left    0
    chunkc set global_desktop_offset_right   0
    chunkc set global_desktop_offset_gap     0
    chunkc set bsp_spawn_left                1
    chunkc set bsp_split_mode                optimal
    chunkc set bsp_optimal_ratio             1.618
    chunkc set bsp_split_ratio               0.66
    chunkc set window_focus_cycle            all
    chunkc set mouse_follows_focus           1
    chunkc set window_region_locked          1
    # chwm-sa additions
    # https://github.com/koekeishiya/chwm-sa
    # warn: triggered via an impure service org.nixos.chwm-sa
    chunkc set window_float_topmost          1
    chunkc set window_fade_inactive          1
    chunkc set window_fade_alpha             0.7
    chunkc set window_fade_duration          0.1
    chunkc tiling::rule --owner Dash --state float
	chunkc tiling::rule --owner Spotify --desktop 5 --follow-desktop
	chunkc tiling::rule --owner Slack --desktop 4 --follow-desktop
  '';
  services.skhd.enable = true;
  services.skhd.package =  pkgs.skhd;
  services.skhd.skhdConfig = let
    modMask = "ctrl+alt";
    moveMask = "ctrl+alt+shift";
	myTerminal = "/run/current-system/sw/bin/openITerm";
    myEditor = "/run/current-system/sw/bin/openNVim";
    noop = "/dev/null";
  in ''
    # windows ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁
    # select
    ${modMask} - j                        : chunkc tiling::window --focus prev 
    ${modMask} - k                        : chunkc tiling::window --focus next
    # close
    ${modMask} - ${keycodes.Delete}       : chunkc tiling::window --close
    # fullscreen
    ${modMask} - h                        : chunkc tiling::window --toggle fullscreen
    # equalize 
    ${modMask} - l                        : chunkc tiling::desktop --equalize
    # swap 
    ${moveMask} - h                       : chunkc tiling::window --swap west
    ${moveMask} - j                       : chunkc tiling::window --swap south
    ${moveMask} - k                       : chunkc tiling::window --swap north
    ${moveMask} - l                       : chunkc tiling::window --swap east
	# increase region
    ${modMask} - a : chunkc tiling::window --use-temporary-ratio 0.05 --adjust-window-edge west; chunkc tiling::window --use-temporary-ratio -0.05 --adjust-window-edge east
	${modMask} - s : chunkc tiling::window --use-temporary-ratio 0.05 --adjust-window-edge south; chunkc tiling::window --use-temporary-ratio -0.05 --adjust-window-edge north
	${modMask} - w : chunkc tiling::window --use-temporary-ratio 0.05 --adjust-window-edge north; chunkc tiling::window --use-temporary-ratio -0.05 --adjust-window-edge south
	${modMask} - d : chunkc tiling::window --use-temporary-ratio 0.05 --adjust-window-edge east; chunkc tiling::window --use-temporary-ratio -0.05 --adjust-window-edge west
    # spaces ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁
    # switch 
#    ${modMask} + alt - a                  : chunkc tiling::desktop --focus prev
#    ${modMask} + alt - r                  : chunkc tiling::desktop --focus next
    # send window 
    ${moveMask} - a          : chunkc tiling::window --send-to-desktop prev -D
    ${moveMask} - r          : chunkc tiling::window --send-to-desktop next -D
    # monitor  ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁
    # focus 
    ${modMask} - left                     : chunkc tiling::monitor -f prev
    ${modMask} - right                    : chunkc tiling::monitor -f next
    # send window
    ${moveMask} - right                   : chunkc tiling::window --send-to-monitor 1 -D
    ${moveMask} - left                    : chunkc tiling::window --send-to-monitor 2 -D
    # apps  ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁
    ${modMask} - return                  : ${myTerminal} 
    ${modMask} + shift - return          : ${myEditor}
    # reset  ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁
    ${modMask} - q                       : killall chunkwm
  '';

  environment.shellAliases = import ./nix/aliases.nix;
  environment.variables = import ./nix/variables.nix;
  environment.loginShell = "/run/current-system/sw/bin/bash";

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.bash.enable = true;
  programs.bash.enableCompletion = true;

  programs.tmux.enable = true;
  programs.tmux.enableSensible = true;
  programs.tmux.enableFzf = true;
  programs.tmux.enableVim = true;
}
