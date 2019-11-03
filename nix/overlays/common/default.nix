self: super: {
  todoist = import ./todoist self;
  myscripts = import ./scripts self super;
  runcached = import ./runcached self;
}
