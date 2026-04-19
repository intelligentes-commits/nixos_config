{ config, pkgs, helium, ... }: {
  # ===== ОСНОВНОЕ =====
  home.username = "int";
  home.homeDirectory = "/home/int";

  # ===== ПРИЛОЖЕНИЯ =====
  home.packages = with pkgs; [
    helium.packages.x86_64-linux.default  # Helium browser
  ];

  # ===== NIRI =====
  programs.niri = {
    enable = true;
    settings = {
      # Keybinds
      binds = with config.lib.niri.actions; {
        "Mod+T".action = spawn "kitty";
        "Mod+Q".action = close-window;
        "Mod+Shift+E".action = quit;  # выход из niri
      };
    };
  };

  # ===== KITTY =====
  programs.kitty.enable = true;

  # ===== HELIX =====
  programs.helix.enable = true;

  # ===== WAYBAR =====
  programs.waybar.enable = true;

  home.stateVersion = "25.05";
}
