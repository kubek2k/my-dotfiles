{ config, pkgs, ... }:

{
  imports = [ <home-manager/nix-darwin> ];
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [];

  fonts.packages = with pkgs; [ (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" ]; }) ];

  environment.shells = [ 
    pkgs.bashInteractive 
    pkgs.zsh 
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  users.users."jakub.janczak" = {
    name = "jakub.janczak";
    home = "/Users/jakub.janczak";
  };

  environment.launchDaemons = {
    "limit.maxfiles.plist" = {
      enable = true;
      source = ./nix/launchd/limit.maxfiles.plist;
    };
  };

  home-manager.verbose = true;
  home-manager.users."jakub.janczak" = { pkgs, ... }: {
    home.packages = [ 
       pkgs.atool 
       pkgs.httpie 
       pkgs.jq
       pkgs.fd
       pkgs.fzf
       pkgs.ripgrep
       pkgs.bat
       pkgs.tmux

       pkgs.git
       pkgs.gh

       pkgs.eza

      # iterm2
      # TODO - add darwin condition here
      pkgs.iterm2
    ];

    programs.bash = import ./nix/bash.nix;

    programs.powerline-go = {
      enable = true;
      modules = [ 
        "time"
        "ssh" 
        "direnv" 
        "docker" 
        "exit" 
        "cwd"
        "git" 
        "kube" 
        "nix-shell"
      ];
      settings = {
        theme = "gruvbox";
        colorize-hostname = true;
      };
    };

    programs.git = import ./nix/git.nix;

    programs.autojump = {
     enable = true;
     enableBashIntegration = true;
     enableZshIntegration = true;
    };

    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    programs.neovim = (import ./nix/neovim.nix) pkgs;

    programs.tmux = import ./nix/tmux.nix;

    ## alternative bitwarden client
    #programs.rbw = {
      #enable = true;
      #settings = {
        #email = "kubek2k@gmail.com";
        #pinentry = "curses";
      #};
    #};

    home.stateVersion = "23.11";
  };
}
