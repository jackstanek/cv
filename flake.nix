{
  description = "CV";
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-23.05;
    flake-utils.url = github:numtide/flake-utils;
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        docname = "cv";
        pkgs = nixpkgs.legacyPackages.${system};
        tex = pkgs.texlive.combine {
          inherit
            (pkgs.texlive)
            scheme-small
            latexmk
            multirow
            ebgaramond
          ;
        };
        deps = with pkgs; [ tex coreutils just bash texlab ];
      in rec {
        devShells.default = pkgs.mkShell {
          buildInputs = deps;
          shellHook = ''
            export DOCNAME=${docname}
          '';
        };
        packages = {
          document = pkgs.stdenvNoCC.mkDerivation rec {
            name = "cv";
            src = self;
            buildInputs = deps;
            phases = ["unpackPhase" "buildPhase" "installPhase"];
            buildPhase = ''
              export DOCNAME="${docname}"
              export PATH="${pkgs.lib.makeBinPath buildInputs}"
              just build
            '';
            installPhase = ''
              mkdir -p $out
              cp build/${docname}.pdf $out/
            '';
          };
        };
        packages.default = packages.document;
      });
}
