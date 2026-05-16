{ config, pkgs, helium, niri, ... }: {
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
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    mpv
    networkmanagerapplet
    obsidian
    ouch
    p7zip
    pavucontrol
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

  fonts.fontconfig.enable = true;

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
    package = niri.packages.${pkgs.stdenv.hostPlatform.system}.niri-unstable;
    settings = {
      input.keyboard.xkb = {
        layout = "us,ru";
        options = "grp:caps_toggle";
      };

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

  xdg.configFile."waybar/scripts/niri-language".text = ''
    #!/usr/bin/env bash
    set -euo pipefail

    print_layout() {
      niri msg -j keyboard-layouts \
        | jq -r '.names[.current_idx] | if test("russian|ru"; "i") then "RU" elif test("english|us"; "i") then "EN" else .[0:2] | ascii_upcase end'
    }

    print_layout

    niri msg -j event-stream | while IFS= read -r event; do
      if jq -e 'has("KeyboardLayoutSwitched") or has("KeyboardLayoutsChanged")' >/dev/null <<< "$event"; then
        print_layout
      fi
    done
  '';
  xdg.configFile."waybar/scripts/niri-language".executable = true;

  # ===== WAYBAR =====
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 34;
        margin-top = 8;
        margin-left = 10;
        margin-right = 10;
        spacing = 8;

        modules-left = [ "niri/workspaces" "niri/window" ];
        modules-center = [ "clock" ];
        modules-right = [ "tray" "custom/language" "idle_inhibitor" "bluetooth" "network" "pulseaudio" "battery" ];

        "niri/workspaces" = {
          format = "{icon}";
          format-icons = {
            active = "󰮯";
            default = "󰊠";
          };
        };

        "niri/window" = {
          format = "{}";
          max-length = 70;
          separate-outputs = true;
        };

        "clock" = {
          interval = 60;
          format = "󰥔 {:%H:%M}";
          format-alt = "󰃭 {:%a, %d %b}";
          tooltip-format = "{:%A, %d %B %Y}";
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󰚥 {capacity}%";
          format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          tooltip-format = "{timeTo} · {capacity}%";
        };

        "network" = {
          format-wifi = "󰤨 {essid}";
          format-ethernet = "󰈀 wired";
          format-disconnected = "󰤭 offline";
          tooltip-format-wifi = "{ifname} · {signalStrength}% · {ipaddr}";
          tooltip-format-ethernet = "{ifname} · {ipaddr}";
          on-click = "nm-connection-editor";
        };

        "bluetooth" = {
          format = "󰂯 {status}";
          format-disabled = "󰂲 off";
          format-connected = "󰂱 {device_alias}";
          tooltip-format = "{controller_alias} · {controller_address}";
          tooltip-format-connected = "{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias} · {device_address}";
          on-click = "blueman-manager";
        };

        "custom/language" = {
          exec = "$HOME/.config/waybar/scripts/niri-language";
          format = "󰌌 {}";
          restart-interval = 1;
          tooltip = false;
          on-click = "niri msg action switch-layout";
        };

        "pulseaudio" = {
          scroll-step = 5;
          format = "{icon} {volume}%";
          format-muted = "󰝟 muted";
          format-icons = {
            default = [ "󰕿" "󰖀" "󰕾" ];
            headphone = "󰋋";
            headset = "󰋎";
          };
          on-click = "pavucontrol";
        };

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "󰅶";
            deactivated = "󰾪";
          };
          tooltip-format-activated = "Idle inhibitor on";
          tooltip-format-deactivated = "Idle inhibitor off";
        };

        "tray" = {
          icon-size = 16;
          spacing = 8;
        };
      };
    };

    style = ''
      @define-color bg #1f1f28;
      @define-color panel #2a2a37;
      @define-color text #dcd7ba;
      @define-color muted #727169;
      @define-color blue #7e9cd8;
      @define-color green #98bb6c;
      @define-color yellow #e6c384;
      @define-color red #e82424;

      * {
        border: 0;
        border-radius: 0;
        font-family: "JetBrainsMono Nerd Font", "Symbols Nerd Font Mono", monospace;
        font-size: 12px;
        font-weight: 600;
        min-height: 0;
      }

      window#waybar {
        background: transparent;
        color: @text;
      }

      tooltip {
        background: @bg;
        border: 1px solid @blue;
        border-radius: 6px;
        color: @text;
      }

      #workspaces,
      #window,
      #clock,
      #tray,
      #custom-language,
      #idle_inhibitor,
      #bluetooth,
      #network,
      #pulseaudio,
      #battery {
        background: alpha(@panel, 0.92);
        border: 1px solid alpha(@blue, 0.22);
        border-radius: 7px;
        margin: 0 2px;
        padding: 0 10px;
      }

      #workspaces {
        padding: 0 4px;
      }

      #workspaces button {
        color: @muted;
        margin: 4px 1px;
        padding: 0 7px;
        border-radius: 6px;
      }

      #workspaces button.active {
        background: alpha(@blue, 0.22);
        color: @blue;
      }

      #workspaces button:hover {
        background: alpha(@blue, 0.14);
        color: @text;
      }

      #window {
        color: @muted;
        min-width: 120px;
      }

      #clock {
        color: @blue;
      }

      #idle_inhibitor.activated {
        color: @yellow;
      }

      #network.disconnected,
      #bluetooth.disabled,
      #pulseaudio.muted {
        color: @muted;
      }

      #battery.warning {
        color: @yellow;
      }

      #battery.critical {
        color: @red;
      }

      #battery.charging,
      #battery.plugged {
        color: @green;
      }
    '';
  };

  home.stateVersion = "25.05";
}
