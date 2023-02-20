{ lib, stdenvNoCC, pkgs, tex }:

let

  init-design = pkgs.callPackage ./large/default.nix { tex = tex; };
  hello-world = pkgs.callPackage ./hello-world/default.nix { tex = tex; };

in stdenvNoCC.mkDerivation rec {
  pname = "docs";
  version = "0.1";

  src = ./.;

  installPhase = ''
    mkdir -p $out
    cp ${init-design}/* $out/
    cp ${hello-world}/* $out/
  '';

  meta = with lib; {
    homepage = "https://github.com/xdHampus/nixtemplates";
    description = ''
      Template for writing latex documents with Nix.
    '';
    licencse = licenses.mit;
    platforms = platforms.all;
    maintainers = with maintainers; [ xdHampus ];
  };
}
