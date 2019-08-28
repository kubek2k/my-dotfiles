pkgs:
  let 
    signal-weechat = pkgs.stdenv.mkDerivation rec {
      pname = "signal-weechat";
      version = "0.0.1";
      src = pkgs.fetchFromGitHub {
        owner = "thefinn93";
        repo = pname;
        rev = "74f7397fc62e7362d469130f9bdcdf1840ee6755";
        sha256 = "1dv0x9vd109665226zmdax484hwmkslimllx0vb38vznh37b1kvb";
      };

      passthru.scripts = [ "signal.py" ];
      installPhase = ''
        install -D signal.py $out/share/signal.py
      '';

      meta = with pkgs.lib; {
        description = "Signal for weechat";
      };
    };
  in
  pkgs.weechat.override {
    configure = { availablePlugins, ... }: {
      scripts = with pkgs.weechatScripts; [
        wee-slack signal-weechat
      ];
      plugins = with availablePlugins; builtins.attrValues (availablePlugins // { 
        python = python.withPackages (ps: with ps; [ ps.dbus-python ] ); 
      });
    };
  }
