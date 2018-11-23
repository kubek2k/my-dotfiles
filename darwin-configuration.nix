{ config, pkgs, ... }:

let 
  keycodes = {
	  A              ="0x00";
	  S              ="0x01";
	  D              ="0x02";
	  F              ="0x03";
	  H              ="0x04";
	  G              ="0x05";
	  Z              ="0x06";
	  X              ="0x07";
	  C              ="0x08";
	  V              ="0x09";
	  B              ="0x0B";
	  Q              ="0x0C";
	  W              ="0x0D";
	  E              ="0x0E";
	  R              ="0x0F";
	  Y              ="0x10";
	  T              ="0x11";
	  k1             ="0x12";
	  k2             ="0x13";
	  k3             ="0x14";
	  k4             ="0x15";
	  k6             ="0x16";
	  k5             ="0x17";
	  Equal          ="0x18";
	  k9             ="0x19";
	  k7             ="0x1A";
	  Minus          ="0x1B";
	  k8             ="0x1C";
	  k0             ="0x1D";
	  RightBracket   ="0x1E";
	  O              ="0x1F";
	  U              ="0x20";
	  LeftBracket    ="0x21";
	  I              ="0x22";
	  P              ="0x23";
	  L              ="0x25";
	  J              ="0x26";
	  Quote          ="0x27";
	  K              ="0x28";
	  Semicolon      ="0x29";
	  Backslash      ="0x2A";
	  Comma          ="0x2B";
	  Slash          ="0x2C";
	  N              ="0x2D";
	  M              ="0x2E";
	  Period         ="0x2F";
	  Grave          ="0x32";
	  KeypadDecimal  ="0x41";
	  KeypadMultiply ="0x43";
	  KeypadPlus     ="0x45";
	  KeypadClear    ="0x47";
	  KeypadDivide   ="0x4B";
	  KeypadEnter    ="0x4C";
	  KeypadMinus    ="0x4E";
	  KeypadEquals   ="0x51";
	  Keypad0        ="0x52";
	  Keypad1        ="0x53";
	  Keypad2        ="0x54";
	  Keypad3        ="0x55";
	  Keypad4        ="0x56";
	  Keypad5        ="0x57";
	  Keypad6        ="0x58";
	  Keypad7        ="0x59";
	  Keypad8        ="0x5B";
	  Keypad9        ="0x5C";
	  Return         ="0x24";
	  Tab            ="0x30";
	  Space          ="0x31";
	  Delete         ="0x33";
	  Escape         ="0x35";
	  Command        ="0x37";
	  Shift          ="0x38";
	  CapsLock       ="0x39";
	  Option         ="0x3A";
	  Control        ="0x3B";
	  RightCommand   ="0x36";
	  RightShift     ="0x3C";
	  RightOption    ="0x3D";
	  RightControl   ="0x3E";
	  Function       ="0x3F";
	  F17            ="0x40";
	  VolumeUp       ="0x48";
	  VolumeDown     ="0x49";
	  Mute           ="0x4A";
	  F18            ="0x4F";
	  F19            ="0x50";
	  F20            ="0x5A";
	  F5             ="0x60";
	  F6             ="0x61";
	  F7             ="0x62";
	  F3             ="0x63";
	  F8             ="0x64";
	  F9             ="0x65";
	  F11            ="0x67";
	  F13            ="0x69";
	  F16            ="0x6A";
	  F14            ="0x6B";
	  F10            ="0x6D";
	  F12            ="0x6F";
	  F15            ="0x71";
	  Help           ="0x72";
	  Home           ="0x73";
	  PageUp         ="0x74";
	  ForwardDelete  ="0x75";
	  F4             ="0x76";
	  End            ="0x77";
	  F2             ="0x78";
	  PageDown       ="0x79";
	  F1             ="0x7A";
	  LeftArrow      ="0x7B";
	  RightArrow     ="0x7C";
	  DownArrow      ="0x7D";
	  UpArrow        ="0x7E";
	};
  overlays = self: super: rec {
    chunkwm = super.recurseIntoAttrs (super.callPackage (super.fetchFromGitHub {
          owner = "kubek2k";
          repo = "chunkwm.nix";
          sha256 = "11fwr29q18x4349wdg1pd7wqd1wvxsib6mjz7c93slf40h88vd53";
          rev = "0.1";
        }) {
          inherit (super.darwin.apple_sdk.frameworks) Carbon Cocoa ApplicationServices;
        });
    openITerm = pkgs.writeScriptBin "openITerm" ''#!/usr/bin/osascript
      tell application "iTerm"
        create window with default profile
      end tell 
      '';
    openNVim = pkgs.writeScriptBin "openNvim" ''#!/usr/bin/osascript
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
  [ pkgs.nix-repl
    pkgs.fzf
    pkgs.fd
    pkgs.entr
    pkgs.jq
    pkgs.autojump
    pkgs.bashInteractive
	pkgs.coreutils
    pkgs.gawk
    pkgs.bat

    pkgs.curl
    pkgs.wget

    pkgs.neovim
    pkgs.global
    pkgs.ctags
    pkgs.ranger
    pkgs.highlight

    pkgs.gitAndTools.gitFull
    pkgs.gist
    pkgs.gitAndTools.hub
    pkgs.git-secret

    pkgs.ncftp

    pkgs.awscli
    pkgs.travis

    pkgs.chunkwm.core
    pkgs.chunkwm.ffm
    pkgs.chunkwm.tiling
    pkgs.openITerm
    pkgs.openNVim

    pkgs.lzma
    pkgs.ag

    pkgs.pwgen

    pkgs.terraform

    pkgs.gnupg
    pkgs.dhall
    ];

    environment.pathsToLink = [
      "/share/vim-plugins"
      "/share/emacs/site-lisp"
    ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.bash.enable = true;
  # programs.zsh.enable = true;
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 3;

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix.maxJobs = 4;
  nix.buildCores = 8;

  environment.variables.EDITOR = "nvim";
 
  environment.shellAliases.e = "$EDITOR";
  environment.shellAliases.g = "git log --pretty=color -32";
  environment.shellAliases.gb = "git branch";
  environment.shellAliases.gc = "git checkout";
  environment.shellAliases.gcb = "git checkout -B";
  environment.shellAliases.gd = "git diff --minimal --patch";
  environment.shellAliases.gf = "git fetch";
  environment.shellAliases.gg = "git log --format=oneline --abbrev-commit --decorate --graph --all";
  environment.shellAliases.gl = "git log --format=oneline --abbrev-commit --all";
  environment.shellAliases.grh = "git reset --hard";
  environment.shellAliases.gs = "git status";
  environment.shellAliases.gpr = "git pull-request";
  environment.shellAliases.l = "ls -lh";
  environment.shellAliases.ls = "ls --color";
  environment.shellAliases.s = "soji";

  nixpkgs.overlays = [ overlays ];
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
}
