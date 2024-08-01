{
  enable = true;
  enableCompletion = true;
  sessionVariables = {
    EDITOR="nvim";
  };
  initExtra = ''
    source $HOME/.nixpkgs/nix/../bash/fzf.sh
  '';
  shellAliases = {
    ll = "exa -l --git --icons";
    la = "exa -la --git --icons";
    lt = "exa --tree --git --icons";
  };
}
