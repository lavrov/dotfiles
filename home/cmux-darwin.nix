{ lib, stdenv, fetchurl, _7zz }:

stdenv.mkDerivation {
  pname = "cmux";
  version = "0.64.24";

  src = fetchurl {
    url = "https://github.com/manaflow-ai/cmux/releases/download/v0.64.24/cmux-macos.dmg";
    sha256 = "sha256-W9pcqZepNp3kW+bjT+nG57VbRM1C0Heext0Uw5uDCSQ=";
  };

  nativeBuildInputs = [ _7zz ];

  # The cmux dmg is APFS-formatted; undmg only supports HFS. 7zz can extract
  # APFS images directly without mounting.
  sourceRoot = ".";
  unpackPhase = ''
    runHook preUnpack
    7zz x -snld $src
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/Applications
    cp -r */*.app $out/Applications/ 2>/dev/null || cp -r *.app $out/Applications/
    runHook postInstall
  '';

  meta = {
    description = "Terminal built for multitasking, organization, and programmability, on top of libghostty";
    homepage = "https://cmux.com";
    platforms = lib.platforms.darwin;
    mainProgram = "cmux";
  };
}
