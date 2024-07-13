{
  description = "Latex package for typesetting math solutions";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    let
      system = flake-utils.lib.system.x86_64-linux;
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.${system} = {
        default = pkgs.mkShell { buildInputs = [ pkgs.texliveFull ]; };
      };
      overlays = {
        hippoid-tex = final: prev: {
          hippoid-tex = prev.callPackage ./hippoid-tex.nix { };
        };
      };
    };
}
