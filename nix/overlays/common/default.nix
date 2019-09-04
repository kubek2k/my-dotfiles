self: super: {
  todoist = import ./todoist self;
  myscripts = import ./scripts self super;
}
