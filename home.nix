{ config, pkgs, helium, ... }: {
  # ===== ОСНОВНОЕ =====
  home.username = "int";
  home.homeDirectory = "/home/int";

  # ===== ПРИЛОЖЕНИЯ =====
  home.packages = with pkgs; [
    codex
    helium.packages.x86_64-linux.default  # Helium browser
    eza
    ffmpegthumbnailer
    fd
    grim
    imagemagick
    libnotify
    localsend
    mako
    slurp
    swappy
    wl-clipboard
    cliphist
    file
    imv
    jq
    mpv
    obsidian
    ouch
    p7zip
    poppler
    ripgrep
    swww
    telegram-desktop
    unrar
    unzip
    xdg-utils
    yazi
    zed-editor
    zip
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
      wall = "swww img --transition-type any --transition-duration 1";
      y = "yazi";
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

  # ===== MAKO =====
  xdg.configFile."mako/config".text = ''
    font=monospace 10
    width=360
    height=120
    margin=12
    padding=12
    border-size=2
    border-radius=6
    default-timeout=5000
    background-color=#1f1f28
    text-color=#dcd7ba
    border-color=#7e9cd8
    progress-color=over #7e9cd8
  '';

  # ===== NIRI =====
  programs.niri = {
    enable = true;
    settings = {
      binds = with config.lib.niri.actions; {
        "Mod+T".action = spawn "kitty";
        "Mod+D".action = spawn "fuzzel";
        "Mod+Q".action = close-window;
        "Mod+Shift+E".action = quit;
        "Mod+V".action = spawn "sh" "-c" "cliphist list | fuzzel --dmenu | cliphist decode | wl-copy";
        "Print".action = spawn "sh" "-c" "mkdir -p ~/Pictures/Screenshots && grim ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png";
        "Shift+Print".action = spawn "sh" "-c" "grim -g \"$(slurp)\" - | wl-copy";
        "Mod+Shift+S".action = spawn "sh" "-c" "mkdir -p ~/Pictures/Screenshots && grim -g \"$(slurp)\" ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png";
        "Mod+Print".action = spawn "sh" "-c" "grim -g \"$(slurp)\" - | swappy -f -";
      };

      # Автозапуск waybar
      spawn-at-startup = [
        { command = [ "waybar" ]; }
        { command = [ "mako" ]; }
        { command = [ "swww-daemon" ]; }
        { command = [ "wl-paste" "--watch" "cliphist" "store" ]; }
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
        modules-right = [ "tray" "bluetooth" "network" "battery" "pulseaudio" ];

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

        "bluetooth" = {
          format = "BT {status}";
          format-disabled = "BT off";
          format-connected = "BT {device_alias}";
          tooltip-format = "{controller_alias} {controller_address}";
          tooltip-format-connected = "{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias} {device_address}";
          on-click = "blueman-manager";
        };

        "pulseaudio" = {
          format = "{volume}% {icon}";
          format-icons = { default = [ "" "" "" ]; };
        };

        "tray" = {
          icon-size = 16;
          spacing = 8;
        };
      };
    };
  };

  home.stateVersion = "25.05";
}
