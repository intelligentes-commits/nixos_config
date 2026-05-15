{ config, pkgs, helium, ... }: {
  # ===== ОСНОВНОЕ =====
  home.username = "int";
  home.homeDirectory = "/home/int";

  # ===== ПРИЛОЖЕНИЯ =====
  home.packages = with pkgs; [
    helium.packages.x86_64-linux.default  # Helium browser
    eza
    fd
    ripgrep
  ];

  # ===== SHELL =====
  programs.fish = {
    enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake .#ideapad";
      nrt = "sudo nixos-rebuild test --flake .#ideapad";
      nrb = "sudo nixos-rebuild boot --flake .#ideapad";
      ncheck = "nix flake check";
      nup = "nix flake update";

      cat = "bat";
      ls = "eza --icons --group-directories-first";
      ll = "eza -la --icons --group-directories-first";
      la = "eza -a --icons --group-directories-first";
      grep = "rg";
    };
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.bat.enable = true;

  # ===== NIRI =====
  programs.niri = {
    enable = true;
    settings = {
      binds = with config.lib.niri.actions; {
        "Mod+T".action = spawn "kitty";
        "Mod+D".action = spawn "fuzzel";
        "Mod+Q".action = close-window;
        "Mod+Shift+E".action = quit;
      };

      # Автозапуск waybar
      spawn-at-startup = [
        { command = [ "waybar" ]; }
      ];
    };
  };

  # ===== FUZZEL (лаунчер) =====
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "kitty";
      };
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
