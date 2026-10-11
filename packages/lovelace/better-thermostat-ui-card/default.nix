{
  stdenv,
  lib,
  pkgs,
  fetchFromGitHub,
}:

stdenv.mkDerivation {
  pname = "better-thermostat-ui-card";
  version = "3.3.0";

  src = import ./source.nix { inherit fetchFromGitHub; };

  nativeBuildInputs = [
    pkgs.bun2nix.hook
  ];

  bunDeps = pkgs.bun2nix.fetchBunDeps {
    bunNix = ./bun.nix;
  };
  buildPhase = ''
    runHook preBuild
    bun run build
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/
    cp dist/better-thermostat-ui-card.js $out/
    runHook postInstall
  '';

  passthru.entrypoint = "better-thermostat-ui-card.js";

  meta = {
    description = "Better Thermostat Lovelace card";
    homepage = "https://github.com/KartoffelToby/better-thermostat-ui-card";
    license = lib.licenses.agpl3Only;
  };
}
