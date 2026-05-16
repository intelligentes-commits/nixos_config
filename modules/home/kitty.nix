{ ... }:

let
  theme = import ./theme.nix;
  c = theme.colors;
in

{
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    settings = {
      font_family = "JetBrainsMono Nerd Font";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      font_size = 11.5;

      cursor_shape = "beam";
      cursor_beam_thickness = 1.6;
      cursor_blink_interval = 0;
      cursor_stop_blinking_after = 0;
      cursor_trail = 12;
      cursor_trail_decay = "0.12 0.35";
      cursor_trail_start_threshold = 1;
      cursor_trail_color = c.accent;

      background = c.bg;
      foreground = c.text;
      selection_background = c.accentSoft;
      selection_foreground = c.text;
      background_opacity = "0.96";
      dynamic_background_opacity = true;
      background_blur = 1;
      hide_window_decorations = "titlebar-only";
      window_padding_width = 10;
      confirm_os_window_close = 0;
      enable_audio_bell = false;

      tab_bar_style = "hidden";
      tab_bar_min_tabs = 999;

      color0 = "#efe7d5";
      color1 = c.red;
      color2 = c.green;
      color3 = c.yellow;
      color4 = c.accent;
      color5 = c.magenta;
      color6 = c.cyan;
      color7 = c.text;
      color8 = c.muted;
      color9 = "#c83f4b";
      color10 = "#629555";
      color11 = "#c18414";
      color12 = "#3d83b5";
      color13 = "#a066a0";
      color14 = "#5e9994";
      color15 = "#1f1d19";
    };
  };
}
