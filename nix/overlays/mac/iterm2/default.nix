{ installMacApplicationFromZip, fetchurl, ... }: installMacApplicationFromZip {
  name = "iTerm2";
  appname = "iTerm";
  version = "3.2.6";
  sourceRoot = "iTerm.app";
  src = fetchurl {
    url = "https://iterm2.com/downloads/stable/iTerm2-3_2_6.zip";
    sha256 = "116qmdcbbga8hr9q9n1yqnhrmmq26l7pb5lgvlgp976yqa043i6v";
        # date = 2018-11-26T10:24:24-0800;
      };
      description = "iTerm2 is a replacement for Terminal and the successor to iTerm";
      homepage = https://www.iterm2.com;
    } 
