{
  enable = true;
  baseIndex = 1;
  clock24 = true;
  customPaneNavigationAndResize = true;
  escapeTime = 1;
  aggressiveResize = false;
  extraConfig = builtins.readFile ./../tmux.conf;
  keyMode = "vi";
}
