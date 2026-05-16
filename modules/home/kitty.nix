{ ... }:

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
      cursor_trail_color = "#7e9cd8";

      background = "#1f1f28";
      foreground = "#dcd7ba";
      selection_background = "#2d4f67";
      selection_foreground = "#dcd7ba";
      background_opacity = "0.92";
      dynamic_background_opacity = true;
      background_blur = 1;
      hide_window_decorations = "titlebar-only";
      window_padding_width = 10;
      confirm_os_window_close = 0;
      enable_audio_bell = false;

      tab_bar_style = "hidden";
      tab_bar_min_tabs = 999;

      color0 = "#16161d";
      color1 = "#c34043";
      color2 = "#76946a";
      color3 = "#c0a36e";
      color4 = "#7e9cd8";
      color5 = "#957fb8";
      color6 = "#6a9589";
      color7 = "#c8c093";
      color8 = "#727169";
      color9 = "#e82424";
      color10 = "#98bb6c";
      color11 = "#e6c384";
      color12 = "#7fb4ca";
      color13 = "#938aa9";
      color14 = "#7aa89f";
      color15 = "#dcd7ba";
    };
  };
}
