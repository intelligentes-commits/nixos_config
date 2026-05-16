{ ... }:

{
  imports = [
    ./modules/home/packages.nix
    ./modules/home/shell.nix
    ./modules/home/desktop-assets.nix
    ./modules/home/niri.nix
    ./modules/home/launcher.nix
    ./modules/home/kitty.nix
    ./modules/home/editor.nix
    ./modules/home/waybar.nix
  ];

  home.username = "int";
  home.homeDirectory = "/home/int";
  home.stateVersion = "25.05";
}
