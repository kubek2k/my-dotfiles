pkgs: with pkgs; stdenv.mkDerivation {
    name = "runcached";
    version = "1.0.0";
    src = fetchgit {
      url = https://bitbucket.org/sivann/runcached.git;
      rev = "e51fde05cc52d0c36db936665919023d9ffca952";
      sha256 = "1kkqyr4n0nx3ir4nxrjsscjlf9mbzzk2pd469v3anz3vjmy9586w";
    };
    buildInputs = [ gcc ];
    buildPhase = ''
      make clean && make runcached
    '';
    installPhase = 
    ''
      mkdir -p $out/bin
      cp runcached $out/bin
    '';
    patches = [] ++ stdenv.lib.optional stdenv.isDarwin ./mtime-darwin.patch;
  } 
