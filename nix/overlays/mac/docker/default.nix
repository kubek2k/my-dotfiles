{ installMacApplicationFromZip, fetchurl, ... }: installMacApplicationFromZip {
  name = "Docker";
  version = "17.09.0-ce-mac33";
  sourceRoot = "Docker.app";
  src = fetchurl {
    url = "https://download.docker.com/mac/stable/19543/Docker.dmg";
    sha256 = "08yvj5346fzipypvc5yxhgbagpjv0dqm202f1q2qvj4w9wbl2bzl";
    };
    description = ''
    Docker CE for Mac is an easy-to-install desktop app for building,
    debugging, and testing Dockerized apps on a Mac
    '';
    homepage = https://store.docker.com/editions/community/docker-ce-desktop-mac;
}
