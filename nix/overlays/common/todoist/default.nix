pkgs: pkgs.buildGoPackage rec {
  name = "todoist-${version}";
  version = "v0.13.1";
  goPackagePath = "github.com/sachaos/todoist";
  src = pkgs.fetchFromGitHub {
    owner = "sachaos";
    repo = "todoist";
    rev = "8c17d7ebf9be78cce24414b5aa3d9c8f1098e506";
    sha256 = "1r5kn5sx9g9rvx78cqfh19mqwf7370vk102x1n062whryk1j3562";
  };
  goDeps = ./deps.nix;
}
