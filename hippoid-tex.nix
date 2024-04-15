{ stdenvNoCC }:
stdenvNoCC.mkDerivation rec {
  src = ./hippoidP;
  name = "hippoid-tex";
  pname = name;
  dontUnpack = true;
  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/tex/latex/hippoid-tex
    cd $out/tex/latex/hippoid-tex
    cp $src/hippoidP.sty .
  '';
  tlType = "run";
}
