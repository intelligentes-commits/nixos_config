{ pkgs, niri, ... }:

{
  programs.niri = {
    enable = true;
    package = niri.packages.${pkgs.stdenv.hostPlatform.system}.niri-unstable;
  };

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd niri-session";
      user = "greeter";
    };
  };
}
