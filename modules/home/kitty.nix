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
      font_size = 10.5;

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
      dim_opacity = "1.0";
      hide_window_decorations = "titlebar-only";
      window_padding_width = 8;
      confirm_os_window_close = 0;
      enable_audio_bell = false;

      tab_bar_style = "hidden";
      tab_bar_min_tabs = 999;

      color0 = "#ebe7dd";
      color1 = "#9d313b";
      color2 = "#446d38";
      color3 = "#7a5100";
      color4 = c.accentDark;
      color5 = "#774a80";
      color6 = "#426f6b";
      color7 = c.text;
      color8 = "#6f6a62";
      color9 = "#b84c55";
      color10 = "#4f7f3f";
      color11 = "#8d6108";
      color12 = c.accent;
      color13 = "#8b5f92";
      color14 = "#507f7a";
      color15 = "#24211e";
    };
  };
}
