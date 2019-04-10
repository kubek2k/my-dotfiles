self: super: {
  todoist = import ./todoist self;
  cloudflare-cli = (import ./cfcli { pkgs = self; }).cloudflare-cli;
}
