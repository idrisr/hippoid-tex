{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { nixpkgs, self, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        hippoid-cls = pkgs.writeTextDir "tex/latex/hippoidC.cls"
          (builtins.readFile ./code/hippoidC.cls);
        hippoid-sty = pkgs.writeTextDir "tex/latex/hippoidP.sty"
          (builtins.readFile ./code/hippoidP.sty);
        hippoid-tex = pkgs.symlinkJoin {
          name = "hippoid-tex";
          paths = [ hippoid-sty hippoid-cls ];
        };
      in {
        packages.default = hippoid-tex;
        devShells.default = hippoid-tex;
      });
}
