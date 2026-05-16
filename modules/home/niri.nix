{ config, pkgs, niri, ... }:

let
  theme = import ./theme.nix;
  c = theme.colors;
  dark = theme.name == "dusk";
  gtkThemeName = if dark then "adw-gtk3-dark" else "adw-gtk3";
  qtStyleName = if dark then "adwaita-dark" else "adwaita";
in

{
  programs.niri = {
    enable = true;
    package = niri.packages.${pkgs.stdenv.hostPlatform.system}.niri-unstable;
    settings = {
      prefer-no-csd = true;
      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

      environment = {
        NIXOS_OZONE_WL = "1";
        XCURSOR_THEME = "Bibata-Modern-Classic";
        XCURSOR_SIZE = "20";
        GTK_THEME = gtkThemeName;
        QT_QPA_PLATFORMTHEME = "gtk2";
        QT_STYLE_OVERRIDE = qtStyleName;
        QT_PLUGIN_PATH = "/etc/profiles/per-user/int/lib/qt-5.15.18/plugins:/etc/profiles/per-user/int/lib/qt-6/plugins";
      };
      hotkey-overlay.skip-at-startup = true;

      cursor = {
        theme = "Bibata-Modern-Classic";
        size = 20;
      };

      input = {
        focus-follows-mouse = {
          enable = true;
          max-scroll-amount = "0%";
        };

        warp-mouse-to-focus.enable = true;
        workspace-auto-back-and-forth = true;

        keyboard = {
          numlock = true;
          repeat-delay = 300;
          repeat-rate = 50;
          track-layout = "window";
          xkb = {
            layout = "us,ru";
            options = "grp:caps_toggle";
          };
        };

        mouse.accel-profile = "flat";

        touchpad = {
          tap = true;
          natural-scroll = true;
          dwt = true;
          dwtp = true;
          drag = true;
          drag-lock = true;
          accel-speed = 0.35;
          accel-profile = "adaptive";
        };
      };

      gestures = {
        dnd-edge-view-scroll = {
          delay-ms = 250;
          trigger-width = 80;
          max-speed = 1500;
        };

        dnd-edge-workspace-switch = {
          delay-ms = 350;
          trigger-height = 80;
          max-speed = 1000;
        };
      };

      layout = {
        gaps = 12;
        background-color = c.bg;
        center-focused-column = "on-overflow";
        always-center-single-column = true;
        default-column-width.proportion = 0.5;
        preset-column-widths = [
          { proportion = 1. / 3.; }
          { proportion = 1. / 2.; }
          { proportion = 2. / 3.; }
          { proportion = 1.; }
        ];
        preset-window-heights = [
          { proportion = 1. / 3.; }
          { proportion = 1. / 2.; }
          { proportion = 2. / 3.; }
        ];

        focus-ring = {
          enable = true;
          width = 3;
          active.color = c.accent;
          inactive.color = c.panelAlt;
          urgent.color = c.red;
        };

        border.enable = false;

        shadow = {
          enable = true;
          softness = 30;
          spread = 4;
          offset = {
            x = 0;
            y = 5;
          };
          color = c.shadow;
        };

        struts = {
          top = 4;
          bottom = 8;
          left = 8;
          right = 8;
        };
      };

      window-rules = [
        {
          matches = [
            { app-id = "^(helium|firefox|zen|chromium|google-chrome|brave-browser)$"; }
          ];
          scroll-factor = 0.55;
        }
        {
          geometry-corner-radius = {
            top-left = 12.0;
            top-right = 12.0;
            bottom-left = 12.0;
            bottom-right = 12.0;
          };
          clip-to-geometry = true;
          draw-border-with-background = false;
        }
      ];

      layer-rules = [
        {
          matches = [{ namespace = "^launcher$"; }];
          geometry-corner-radius = {
            top-left = 12.0;
            top-right = 12.0;
            bottom-left = 12.0;
            bottom-right = 12.0;
          };
          opacity = 0.96;
          shadow = {
            enable = true;
            softness = 24;
            spread = 3;
            offset = {
              x = 0;
              y = 4;
            };
            color = c.shadowStrong;
          };
        }
      ];

      binds = with config.lib.niri.actions; {
        "Mod+T".action = spawn "kitty";
        "Mod+D".action = spawn "tofi-drun" "--drun-launch=true";
        "Mod+Q".action = close-window;
        "Mod+Shift+E".action = quit;
        "Mod+Slash".action = show-hotkey-overlay;
        "Mod+O".action = toggle-overview;

        "Mod+Left".action = focus-column-left;
        "Mod+Down".action = focus-window-down;
        "Mod+Up".action = focus-window-up;
        "Mod+Right".action = focus-column-right;
        "Mod+H".action = focus-column-left;
        "Mod+J".action = focus-window-down;
        "Mod+K".action = focus-window-up;
        "Mod+L".action = focus-column-right;

        "Mod+Ctrl+Left".action = move-column-left;
        "Mod+Ctrl+Down".action = move-window-down;
        "Mod+Ctrl+Up".action = move-window-up;
        "Mod+Ctrl+Right".action = move-column-right;
        "Mod+Ctrl+H".action = move-column-left;
        "Mod+Ctrl+J".action = move-window-down;
        "Mod+Ctrl+K".action = move-window-up;
        "Mod+Ctrl+L".action = move-column-right;

        "Mod+Home".action = focus-column-first;
        "Mod+End".action = focus-column-last;
        "Mod+Ctrl+Home".action = move-column-to-first;
        "Mod+Ctrl+End".action = move-column-to-last;

        "Mod+Shift+Left".action = focus-monitor-left;
        "Mod+Shift+Down".action = focus-monitor-down;
        "Mod+Shift+Up".action = focus-monitor-up;
        "Mod+Shift+Right".action = focus-monitor-right;
        "Mod+Shift+H".action = focus-monitor-left;
        "Mod+Shift+J".action = focus-monitor-down;
        "Mod+Shift+K".action = focus-monitor-up;
        "Mod+Shift+L".action = focus-monitor-right;

        "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
        "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down;
        "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up;
        "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
        "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
        "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
        "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
        "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;

        "Mod+Page_Down".action = focus-workspace-down;
        "Mod+Page_Up".action = focus-workspace-up;
        "Mod+U".action = focus-workspace-down;
        "Mod+I".action = focus-workspace-up;
        "Mod+Tab".action = focus-workspace-previous;

        "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
        "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;
        "Mod+Ctrl+U".action = move-column-to-workspace-down;
        "Mod+Ctrl+I".action = move-column-to-workspace-up;

        "Mod+Shift+Page_Down".action = move-workspace-down;
        "Mod+Shift+Page_Up".action = move-workspace-up;
        "Mod+Shift+U".action = move-workspace-down;
        "Mod+Shift+I".action = move-workspace-up;

        "Mod+1".action = focus-workspace 1;
        "Mod+2".action = focus-workspace 2;
        "Mod+3".action = focus-workspace 3;
        "Mod+4".action = focus-workspace 4;
        "Mod+5".action = focus-workspace 5;
        "Mod+6".action = focus-workspace 6;
        "Mod+7".action = focus-workspace 7;
        "Mod+8".action = focus-workspace 8;
        "Mod+9".action = focus-workspace 9;

        "Mod+Comma".action = consume-window-into-column;
        "Mod+Period".action = expel-window-from-column;
        "Mod+R".action = switch-preset-column-width;
        "Mod+Shift+R".action = switch-preset-column-width-back;
        "Mod+F".action = maximize-column;
        "Mod+Shift+F".action = fullscreen-window;
        "Mod+M".action = maximize-window-to-edges;
        "Mod+C".action = center-column;
        "Mod+Ctrl+C".action = center-visible-columns;
        "Mod+Minus".action = set-column-width "-10%";
        "Mod+Equal".action = set-column-width "+10%";
        "Mod+Shift+Minus".action = set-window-height "-10%";
        "Mod+Shift+Equal".action = set-window-height "+10%";
        "Mod+Alt+V".action = toggle-window-floating;
        "Mod+Alt+Shift+V".action = switch-focus-between-floating-and-tiling;
        "Mod+Escape".action = toggle-keyboard-shortcuts-inhibit;

        "Mod+V".action = spawn "sh" "-c" "cliphist list | tofi --prompt-text 'clipboard: ' | cliphist decode | wl-copy";
        "Print".action = spawn "sh" "-c" "mkdir -p ~/Pictures/Screenshots && grim ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png";
        "Shift+Print".action = spawn "sh" "-c" "grim -g \"$(slurp)\" - | wl-copy";
        "Mod+Shift+S".action = spawn "sh" "-c" "mkdir -p ~/Pictures/Screenshots && grim -g \"$(slurp)\" ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png";
        "Mod+Print".action = spawn "sh" "-c" "grim -g \"$(slurp)\" - | swappy -f -";

        "XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+";
        "XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-";
        "XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
        "XF86AudioMicMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
        "XF86AudioPlay".action = spawn "playerctl" "play-pause";
        "XF86AudioStop".action = spawn "playerctl" "stop";
        "XF86AudioPrev".action = spawn "playerctl" "previous";
        "XF86AudioNext".action = spawn "playerctl" "next";
        "XF86MonBrightnessUp".action = spawn "brightnessctl" "--class=backlight" "set" "+10%";
        "XF86MonBrightnessDown".action = spawn "brightnessctl" "--class=backlight" "set" "10%-";
      };

      spawn-at-startup = [
        { command = [ "waybar" ]; }
        { command = [ "mako" ]; }
        { command = [ "awww-daemon" ]; }
        {
          command = [
            "sh"
            "-c"
            "mkdir -p ~/.cache && sleep 1 && ${pkgs.imagemagick}/bin/magick ~/.config/wallpapers/default.svg ~/.cache/niri-wallpaper.png && ${pkgs.awww}/bin/awww img --transition-type fade --transition-duration 1 ~/.cache/niri-wallpaper.png"
          ];
        }
        { command = [ "wl-paste" "--watch" "cliphist" "store" ]; }
      ];
    };
  };
}
