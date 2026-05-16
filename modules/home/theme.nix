let
  themes = {
    paper = {
      name = "paper";

      colors = {
        bg = "#f7f5ef";
        bgAlpha = "#f7f5eff2";
        panel = "#efede6";
        panelAlt = "#e4e1d8";
        text = "#34312d";
        muted = "#8a857c";
        accent = "#9a7cff";
        accentSoft = "#ece7ff";
        accentDark = "#6f57cc";
        green = "#5f7f52";
        yellow = "#a17218";
        red = "#b84c55";
        magenta = "#9b6ba2";
        cyan = "#5f8580";
        shadow = "#5f574833";
        shadowStrong = "#5f574844";
      };

      wallpaper = {
        bg0 = "#faf8f2";
        bg1 = "#f4f1e9";
        bg2 = "#ebe8df";
        moon0 = "#fff8dc";
        moon1 = "#d8c895";
        glow0 = "#c9c0ff";
        glow1 = "#9a7cff";
        wave0 = "#d8d2c4";
        wave1 = "#cfc7ff";
        wave2 = "#e0d6ce";
        hill0 = "#ebe6dc";
        hill1 = "#e1ddd4";
        star = "#9a948a";
      };
    };

    dusk = {
      name = "dusk";

      colors = {
        bg = "#17161d";
        bgAlpha = "#17161df2";
        panel = "#22202a";
        panelAlt = "#2c2934";
        text = "#e8e2d2";
        muted = "#a7a096";
        accent = "#b69cff";
        accentSoft = "#342b51";
        accentDark = "#d7c9ff";
        green = "#9dbf8a";
        yellow = "#d8ad62";
        red = "#e07a84";
        magenta = "#d19ad6";
        cyan = "#8fc5bf";
        shadow = "#05040766";
        shadowStrong = "#05040788";
      };

      wallpaper = {
        bg0 = "#17161d";
        bg1 = "#211f2a";
        bg2 = "#2b2834";
        moon0 = "#efe1b7";
        moon1 = "#c8a96b";
        glow0 = "#7f66d6";
        glow1 = "#b69cff";
        wave0 = "#5d7269";
        wave1 = "#7b68c5";
        wave2 = "#87658c";
        hill0 = "#111018";
        hill1 = "#191923";
        star = "#e8e2d2";
      };
    };
  };
in
themes.dusk
