{
  description = "Latex package for typesetting math solutions";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { nixpkgs, self, flake-utils }:
    let
      system = flake-utils.lib.system.x86_64-linux;
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ self.overlays.hippoid-tex ];
      };
      makepdf = pkgs.runCommand "mydoc" { src = ./sample.tex; } ''
        mkdir -p $out
        cd $out
        ${tex}/bin/latexmk -interaction=nonstopmode -lualatex -pdf \
        -auxdir=aux -outdir=pdf $src
      '';
      cleaner = pkgs.writeShellApplication {
        runtimeInputs = [ tex ];
        name = "clean";
        text = ''
          latexmk -C -auxdir=aux -outdir=pdf
          latexmk -C -auxdir=. -outdir=.
        '';
      };
      tex = pkgs.texlive.combine {
        inherit (pkgs.texlive) scheme-full;
        hippoid-tex = { pkgs = [ pkgs.hippoid-tex ]; };
      };
    in {
      packages.${system} = {
        inherit makepdf;
        inherit cleaner;
      };
      devShells.${system} = {
        default = pkgs.mkShell { buildInputs = [ tex ]; };
      };
      checks.${system} = {
        inherit cleaner;
        inherit makepdf;
      };
      overlays = {
        hippoid-tex = final: prev: {
          hippoid-tex = prev.callPackage ./hippoid-tex.nix { };
        };
      };
      apps.${system} = {
        clean = {
          type = "app";
          program = "${cleaner}/bin/clean";
        };
      };
    };
}
