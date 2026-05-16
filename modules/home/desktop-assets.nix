{ pkgs, ... }:

let
  theme = import ./theme.nix;
  c = theme.colors;
in

{
  home.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "20";
  };

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 20;
    gtk.enable = true;
    x11.enable = true;
  };

  xdg.configFile."mako/config".text = ''
    font=monospace 9
    width=360
    height=120
    margin=12
    padding=12
    border-size=2
    border-radius=6
    default-timeout=5000
    background-color=${c.panel}
    text-color=${c.text}
    border-color=${c.accent}
    progress-color=over ${c.accent}
  '';

  xdg.configFile."wallpapers/default.svg".text = ''
    <svg xmlns="http://www.w3.org/2000/svg" width="2560" height="1440" viewBox="0 0 2560 1440">
      <defs>
        <linearGradient id="bg" x1="0" y1="0" x2="1" y2="1">
          <stop offset="0%" stop-color="#faf8f2"/>
          <stop offset="48%" stop-color="#f4f1e9"/>
          <stop offset="100%" stop-color="#ebe8df"/>
        </linearGradient>
        <radialGradient id="moon" cx="50%" cy="50%" r="50%">
          <stop offset="0%" stop-color="#fff8dc" stop-opacity="1"/>
          <stop offset="42%" stop-color="#d8c895" stop-opacity="0.32"/>
          <stop offset="100%" stop-color="#d8c895" stop-opacity="0"/>
        </radialGradient>
        <radialGradient id="blueGlow" cx="50%" cy="50%" r="50%">
          <stop offset="0%" stop-color="#c9c0ff" stop-opacity="0.30"/>
          <stop offset="100%" stop-color="#9a7cff" stop-opacity="0"/>
        </radialGradient>
        <linearGradient id="wave" x1="0" y1="0" x2="1" y2="0">
          <stop offset="0%" stop-color="#d8d2c4" stop-opacity="0.50"/>
          <stop offset="50%" stop-color="#cfc7ff" stop-opacity="0.42"/>
          <stop offset="100%" stop-color="#e0d6ce" stop-opacity="0.48"/>
        </linearGradient>
        <filter id="soft" x="-20%" y="-20%" width="140%" height="140%">
          <feGaussianBlur stdDeviation="28"/>
        </filter>
      </defs>

      <rect width="2560" height="1440" fill="url(#bg)"/>
      <circle cx="2110" cy="250" r="360" fill="url(#moon)" filter="url(#soft)"/>
      <circle cx="500" cy="1140" r="720" fill="url(#blueGlow)" filter="url(#soft)"/>
      <circle cx="2050" cy="1180" r="560" fill="#d8d2c4" opacity="0.20" filter="url(#soft)"/>

      <path d="M0 1010 C360 860 580 1060 910 930 C1240 800 1420 760 1720 850 C2010 936 2220 820 2560 720 L2560 1440 L0 1440 Z"
            fill="#ebe6dc" opacity="0.70"/>
      <path d="M0 1120 C340 1010 690 1160 1020 1035 C1330 916 1600 940 1850 1035 C2130 1140 2320 980 2560 930 L2560 1440 L0 1440 Z"
            fill="#e1ddd4" opacity="0.82"/>
      <path d="M0 1176 C390 1090 650 1215 1010 1130 C1330 1054 1690 1100 1980 1190 C2220 1265 2400 1190 2560 1150 L2560 1440 L0 1440 Z"
            fill="url(#wave)" opacity="1"/>

      <g opacity="0.30" stroke="#9a948a" stroke-width="1.8">
        <path d="M250 245 H450 M350 145 V345"/>
        <path d="M1880 430 H2060 M1970 340 V520"/>
        <path d="M760 610 H880 M820 550 V670"/>
      </g>

      <g opacity="0.42">
        <circle cx="360" cy="310" r="2.2" fill="#9a948a"/>
        <circle cx="620" cy="190" r="1.6" fill="#9a948a"/>
        <circle cx="980" cy="340" r="1.8" fill="#9a948a"/>
        <circle cx="1260" cy="210" r="1.4" fill="#9a948a"/>
        <circle cx="1480" cy="460" r="2" fill="#9a948a"/>
        <circle cx="1780" cy="160" r="1.6" fill="#9a948a"/>
        <circle cx="2250" cy="520" r="1.8" fill="#9a948a"/>
      </g>
    </svg>
  '';
}
