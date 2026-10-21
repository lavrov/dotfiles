{ lib, stdenv, fetchurl, unzip }:

stdenv.mkDerivation rec {
  pname = "claude-desktop";
  version = "3.1623.0";
  commit = "e751f9d5249da803676835a68a9b15463ec5b1d7";

  src = fetchurl {
    url = "https://downloads.claude.ai/releases/darwin/universal/${version}/Claude-${commit}.zip";
    sha256 = "5882a24ede9fc540b92c31da8f3570faf710718a62161b43df41e79e62080191";
  };

  nativeBuildInputs = [ unzip ];

  sourceRoot = ".";

  # Keep the app bundle byte-for-byte intact so its code signature stays valid.
  dontFixup = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/Applications
    cp -R Claude.app $out/Applications/
    runHook postInstall
  '';

  meta = {
    description = "Anthropic's official Claude desktop app";
    homepage = "https://claude.ai/download";
    license = lib.licenses.unfree;
    platforms = lib.platforms.darwin;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
}
