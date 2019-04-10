pkgs: pkgs.recurseIntoAttrs (pkgs.callPackage (pkgs.fetchFromGitHub {
  owner = "kubek2k";
  repo = "chunkwm.nix";
  sha256 = "11fwr29q18x4349wdg1pd7wqd1wvxsib6mjz7c93slf40h88vd53";
  rev = "0.1";
}) {
  inherit (pkgs.darwin.apple_sdk.frameworks) Carbon Cocoa ApplicationServices;
})
