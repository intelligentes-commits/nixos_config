{ config, pkgs, helium, ... }: {
  # ===== ОСНОВНОЕ =====
  home.username = "int";
  home.homeDirectory = "/home/int";

  # ===== ПРИЛОЖЕНИЯ =====
  home.packages = with pkgs; [
    helium.packages.x86_64-linux.default  # Helium browser
  ];

  # ===== NIRI =====
  programs.niri.enable = true;

  # ===== KITTY =====
  programs.kitty.enable = true;

  # ===== HELIX =====
  programs.helix.enable = true;

  # ===== WAYBAR =====
  programs.waybar.enable = true;

  home.stateVersion = "25.05";
}
