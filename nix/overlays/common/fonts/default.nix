pkgs:
 let 
     makeNerdFonts = pkgs.callPackage(pkgs.fetchFromGitHub {
        owner = "kubek2k";
        repo = "make-nerd-fonts.nix";
        rev = "0.3";
        sha256 = "16slr8hrl4bdc94g1zhk3a59668zkss279m091i1l1r3pkwqb5r0";
      });
  in
    rec {
      pragmatapro = let
        version = "0.828-2+nerdfonts";
        installPath = "share/fonts/truetype/";
      in pkgs.stdenv.mkDerivation rec {
        name = "pragmatapro-${version}";
        src = (./. + "/PragmataPro-${version}.zip");
        buildInputs = [ pkgs.unzip ];
        phases = [ "unpackPhase" "installPhase" ];
        pathsToLink = [ "/share/fonts/truetype/" ];
        sourceRoot = ".";
        installPhase = ''
          install_path=$out/${installPath}
          mkdir -p $install_path
          find -name "*.ttf" -exec cp {} $install_path \;
        '';
        meta = with pkgs.stdenv.lib; {
          homepage = "https://www.fsd.it/shop/fonts/pragmatapro/";
          description = ''
            PragmataPro™ is a condensed monospaced font optimized for screen,
            designed by Fabrizio Schiavi to be the ideal font for coding, math and engineering
          '';
          platforms = platforms.all;
        };
      };

      pragmatapro-nerd-fonts = makeNerdFonts pkgs pragmatapro;

      jetbrains-mono = let
        version = "0.2+nerdfonts";
        installPath = "share/fonts/truetype/";
      in pkgs.stdenv.mkDerivation rec {
        name = "jetbrains-mono-${version}";
        src = pkgs.fetchurl {
          url = "https://download.jetbrains.com/fonts/JetBrainsMono-1.0.2.zip";
          sha256 = "0qlp4902i1v6ni04b6gdip8rxw6wpkdk9w7dir1yn9an5mvbkyar";
        };
        buildInputs = [ pkgs.unzip ];
        phases = [ "unpackPhase" "installPhase" ];
        pathsToLink = [ "/share/fonts/truetype/" ];
        sourceRoot = ".";
        installPhase = ''
          install_path=$out/${installPath}/ttf
          mkdir -p $install_path
          find -name "*.ttf" -exec cp {} $install_path \;
        '';
        meta = with pkgs.stdenv.lib; {
          homepage = "https://www.jetbrains.com/lp/mono/";
          description = ''
            JetBrains Mono font face
          '';
          platforms = platforms.all;
        };
      };

      jetbrains-mono-nerd-fonts = makeNerdFonts pkgs jetbrains-mono;
    }
