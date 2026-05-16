{ ... }:

let
  theme = import ./theme.nix;
  c = theme.colors;
in

{
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

  programs.waybar = {
    enable = true;
    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 32;
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

    style = ''
      @define-color bg ${c.bg};
      @define-color panel ${c.panel};
      @define-color text ${c.text};
      @define-color muted ${c.muted};
      @define-color blue ${c.accent};
      @define-color green ${c.green};
      @define-color yellow ${c.yellow};
      @define-color red ${c.red};

      * {
        border: 0;
        border-radius: 0;
        font-family: "JetBrainsMono Nerd Font", "Symbols Nerd Font Mono", monospace;
        font-size: 11px;
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
        background: alpha(@panel, 0.94);
        border: 1px solid alpha(@blue, 0.20);
        border-radius: 7px;
        margin: 0 2px;
        padding: 0 9px;
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
        background: alpha(@blue, 0.16);
        color: @blue;
      }

      #workspaces button:hover {
        background: alpha(@blue, 0.10);
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
}
