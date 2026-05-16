{ autoPatchelfHook
, fetchzip
, fetchurl
, glib
, google-chrome
, gst_all_1
, gtk3
, lib
, nodejs
, stdenv
, webkitgtk_4_1
}:

let
  playwrightDriver = fetchzip {
    url = "https://playwright.azureedge.net/builds/driver/playwright-1.57.0-linux.zip";
    hash = "sha256-sBFW5kNMJeQ2WRMOfUoZGBQnX4qmlIplv/2550cayxg=";
    stripRoot = false;
  };
in
stdenv.mkDerivation rec {
  pname = "vibez";
  version = "0.1.0";

  src = fetchurl {
    url = "https://github.com/simonepelosi/vibez/releases/download/v${version}/vibez_linux_amd64.tar.gz";
    hash = "sha256-n+wSlqDv4IxjRWmSJBx81h6zV19j6vTnXDjmCsUUHvE=";
  };
  sourceRoot = ".";

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    glib
    gst_all_1.gstreamer
    gtk3
    stdenv.cc.cc.lib
    webkitgtk_4_1
  ];

  installPhase = ''
    runHook preInstall

    install -Dm755 vibez $out/libexec/vibez/vibez-real
    mkdir -p $out/bin
    cat > $out/bin/vibez <<EOF
#!${stdenv.shell}
set -euo pipefail

cache_home="\''${XDG_CACHE_HOME:-\''${HOME}/.cache}"
driver_dir="\''${cache_home}/vibez/driver"
chrome_dir="\''${cache_home}/vibez/chrome"
chrome_opt_dir="\''${chrome_dir}/opt/google/chrome"

if [ "\$(readlink "\''${driver_dir}" 2>/dev/null || true)" != "${playwrightDriver}" ]; then
  rm -rf "\''${driver_dir}"
  mkdir -p "\$(dirname "\''${driver_dir}")"
  ln -s ${playwrightDriver} "\''${driver_dir}"
fi

if [ "\$(readlink "\''${chrome_opt_dir}/chrome" 2>/dev/null || true)" != "${google-chrome}/bin/google-chrome-stable" ]; then
  rm -rf "\''${chrome_dir}"
  mkdir -p "\''${chrome_opt_dir}"
  ln -s ${google-chrome}/bin/google-chrome-stable "\''${chrome_opt_dir}/chrome"
  ln -s ${google-chrome}/bin/google-chrome-stable "\''${chrome_opt_dir}/vibez-helper"
  ln -s ${google-chrome}/share/google/chrome/WidevineCdm "\''${chrome_opt_dir}/WidevineCdm"
fi

export PLAYWRIGHT_NODEJS_PATH=${nodejs}/bin/node
exec $out/libexec/vibez/vibez-real "\$@"
EOF
    chmod +x $out/bin/vibez
    install -Dm644 README.md CHANGELOG.md -t $out/share/doc/${pname}
    install -Dm644 LICENSE -t $out/share/licenses/${pname}

    runHook postInstall
  '';

  meta = {
    description = "Keyboard-first Apple Music TUI for Linux";
    homepage = "https://github.com/simonepelosi/vibez";
    license = lib.licenses.mit;
    mainProgram = "vibez";
    platforms = [ "x86_64-linux" ];
  };
}
