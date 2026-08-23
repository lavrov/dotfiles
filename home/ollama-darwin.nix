{ lib, stdenv, fetchzip, makeWrapper }:

stdenv.mkDerivation {
  pname = "ollama-darwin";
  version = "0.32.15";

  src = fetchzip {
    url = "https://github.com/ollama/ollama/releases/download/v0.32.15/Ollama-darwin.zip";
    sha256 = "im6/Z8lBZla/lYMR4hcccT0JV5xqaATtFCBSMvWcbuo=";
  };

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/Applications
    if [ -d "Ollama.app" ]; then
      cp -R Ollama.app $out/Applications/
    else
      # fetchzip strips the top-level dir, so Contents/ is at the root
      mkdir -p $out/Applications/Ollama.app
      cp -R Contents $out/Applications/Ollama.app/
    fi

    # Expose the CLI binary bundled inside the app (built with MLX support)
    # so it can be used as a regular `ollama` executable, e.g. by
    # home-manager's `services.ollama` launchd agent.
    mkdir -p $out/bin
    makeWrapper "$out/Applications/Ollama.app/Contents/Resources/ollama" "$out/bin/ollama"
    runHook postInstall
  '';

  meta = {
    description = "Get up and running with large language models on macOS (official build with MLX support)";
    homepage = "https://ollama.com";
    platforms = lib.platforms.darwin;
    mainProgram = "ollama";
  };
}