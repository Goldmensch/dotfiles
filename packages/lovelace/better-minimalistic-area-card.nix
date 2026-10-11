{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchYarnDeps,
  yarnConfigHook,
  yarnBuildHook,
  nodejs,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "better-minimalistic-area-card";
  version = "1.2.42";

  src = fetchFromGitHub {
    owner = "LesTR";
    repo = "homeassistant-minimalistic-area-card";
    rev = "v${finalAttrs.version}";
    hash = "sha256-OoiC4GRxfHdF3TRmOc6MASSNr0Fj71DNc1YqsoEsmPw=";
  };

  yarnOfflineCache = fetchYarnDeps {
    yarnLock = finalAttrs.src + "/yarn.lock";
    hash = "sha256-T/3Na0i3oGbm8AtmGPGHUX2Ik9t2TIKkPSUbDUXPd+0=";
  };

  nativeBuildInputs = [
    yarnConfigHook
    yarnBuildHook
    nodejs
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp dist/better-minimalistic-area-card.js $out/

    runHook postInstall
  '';

  passthru.entrypoint = "better-minimalistic-area-card.js";

  meta = {
    description = "Minimalistic Area Card for Home Assistant";
    homepage = "https://github.com/LesTR/homeassistant-minimalistic-area-card";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
  };
})
