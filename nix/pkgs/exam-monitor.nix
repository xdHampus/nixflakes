{ lib, stdenv, fetchurl, makeWrapper, adoptopenjdk-icedtea-web }:

stdenv.mkDerivation rec {
  pname = "exam-monitor";
  version = "1.0";

  src = fetchurl {
      url = "https://login.exammonitor.dk/exam.jnlp";
      sha256 = "07g2hl42apsyxk1w4psk19dawhkgh8dlp0yr9ap792a9zfqqhmfk";
  };
  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ adoptopenjdk-icedtea-web ];

  

  dontUnpack = true;
  installPhase = ''
    mkdir -p $out/share/java $out/bin
    cp $src $out/share/java/exam.jnlp
    makeWrapper ${adoptopenjdk-icedtea-web}/bin/javaws $out/bin/exam-monitor \
      --add-flags "$out/share/java/exam.jnlp"
  '';

  meta = with lib; {
    homepage = "https://sdu.exammonitor.dk/";
    description = "Digital Exam Monitor for SDU, the University of Southern Denmark";
    platforms = platforms.unix;
    license = licenses.unfree;
    maintainers = with maintainers; [ xdHampus ];
  };
}
