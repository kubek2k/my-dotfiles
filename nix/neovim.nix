pkgs: {
  enable = true;

  plugins = with pkgs.vimPlugins; [
    vim-plug 
    vim-nix 
  ];

  extraConfig = ''
    " guess what!? this line is needed for plug to work
    source ${pkgs.vimPlugins.vim-plug}/plug.vim
    source $HOME/.nixpkgs/nix/nvim/init.vim
  '';
}
