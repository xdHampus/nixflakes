{ lib, stdenv }:

stdenv.mkDerivation rec {
  pname = "standard";
  version = "0.1.0";

  src = ./.;

  buildInputs = [ ];

  installPhase = ''
    	mkdir -p $out/
      echo "Hello world" > $out/hello.txt
  '';

  meta = with lib; {
    homepage = "HOMEPAGE";
    description = ''
      DESCRIPTION
    '';
    licencse = licenses.mit;
    platforms = platforms.all;
    maintainers = with maintainers; [ xdHampus ];
  };
}
