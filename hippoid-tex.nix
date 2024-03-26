{ stdenv }:
stdenv.mkDerivation rec {
  src = ./code;
  name = "hippoid-tex";
  pname = name;
  dontUnpack = true;
  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/tex/latex/
    cp $src/hippoidC.cls $out/tex/latex
    cp $src/hippoidP.sty $out/tex/latex
  '';
  version = "1.2.3";
  tlType = "run";
}
