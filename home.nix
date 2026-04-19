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
      binds = with config.lib.niri.actions; {
        "Mod+T".action = spawn "kitty";
        "Mod+Q".action = close-window;
        "Mod+Shift+E".action = quit;
      };

      # Автозапуск waybar
      spawn-at-startup = [
        { command = [ "waybar" ]; }
      ];
    };
  };

  # ===== KITTY =====
  programs.kitty.enable = true;

  # ===== HELIX =====
  programs.helix.enable = true;

  # ===== WAYBAR =====
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;

        modules-left = [ "niri/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "network" "battery" "pulseaudio" ];

        "clock" = {
          format = "{:%H:%M}";
          tooltip-format = "{:%Y-%m-%d}";
        };

        "battery" = {
          format = "{capacity}% {icon}";
          format-icons = [ "" "" "" "" "" ];
        };

        "network" = {
          format-wifi = "{essid} ";
          format-disconnected = "offline";
        };

        "pulseaudio" = {
          format = "{volume}% {icon}";
          format-icons = { default = [ "" "" "" ]; };
        };
      };
    };
  };

  home.stateVersion = "25.05";
}
