{ writeTextDir }:
writeTextDir "tex/latex" builtins.readFile ./code/hippoid.cls
# mkdir -p $out/tex/latex
# cp ./code/hippoid.cls $out/tex/latex
# cp ./code/hippoid.sty $out/tex/latex
# ''
