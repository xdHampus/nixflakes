{ lib, stdenvNoCC, tex, coreutils }:

stdenvNoCC.mkDerivation rec {
  pname = "docs-hello-world";
  version = "0.1";

  src = ./.;

  buildInputs = [ coreutils tex ];

  phases = [ "unpackPhase" "buildPhase" "installPhase" ];

  buildPhase = ''
    export PATH="${lib.makeBinPath buildInputs}";
    mkdir -p .cache/texmf-var
    env TEXMFHOME=.cache TEXMFVAR=.cache/texmf-var \
      latexmk -interaction=nonstopmode -f -pdf -lualatex \
      ${pname}.tex
  '';

  installPhase = ''
    mkdir -p $out
    cp ${pname}.pdf $out/
  '';

  meta = with lib; {
    homepage = "https://github.com/xdHampus/nixtemplates";
    description = ''
      Hello world example for Nix & LaTeX template
    '';
    licencse = licenses.mit;
    platforms = platforms.all;
    maintainers = [ maintainers.xdHampus ];
  };
}
