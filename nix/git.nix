{
  enable = true;
  aliases = {
    st = "status";
    co = "checkout";
    lol = "log --format=oneline --abbrev-commit --decorate --graph --all";
    cob = "checkout -b";
    del = "branch -D";
    undo = "reset HEAD~1 --mixed";
  };
  userEmail = "jakub.janczak@scrive.com";
  userName = "Jakub Janczak";
  difftastic = {
    enable = true;
  };
  extraConfig = {
    pull.ff = "only";
    rerere.enabled = true;
    branch = {
      autosetuprebase = "always";
      autosetupmerge = "always";
    };
    color.ui = "auto";
    push = {
      default = "current";
      autoSetupRemote = true;
    };
    core.excludesfile = "~/Dotfiles/gitignore";
    merge = {
      conflictstyle = "diff3";
    };
  };
}
