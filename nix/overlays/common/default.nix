self: super: {
  todoist = import ./todoist super;
  cloudflare-cli = (import ./cfcli { pkgs = super; }).cloudflare-cli;
  weechat = import ./weechat super;
}
