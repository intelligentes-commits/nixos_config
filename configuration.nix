{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/system/base.nix
    ./modules/system/desktop.nix
    ./modules/system/niri.nix
  ];

  system.stateVersion = "25.05";
}
