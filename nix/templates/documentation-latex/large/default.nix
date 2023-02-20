{ lib, stdenvNoCC, tex, coreutils }:

stdenvNoCC.mkDerivation rec {
  pname = "docs-template-main";
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
      Documentation
    '';
    licencse = licenses.mit;
    platforms = platforms.all;
    maintainers = with maintainers; [ xdHampus ];
  };
}
