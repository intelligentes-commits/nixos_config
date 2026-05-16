{ ... }:

{
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

  xdg.configFile."wallpapers/default.svg".text = ''
    <svg xmlns="http://www.w3.org/2000/svg" width="2560" height="1440" viewBox="0 0 2560 1440">
      <defs>
        <linearGradient id="bg" x1="0" y1="0" x2="1" y2="1">
          <stop offset="0%" stop-color="#202033"/>
          <stop offset="45%" stop-color="#2d2d42"/>
          <stop offset="100%" stop-color="#3a334f"/>
        </linearGradient>
        <radialGradient id="moon" cx="50%" cy="50%" r="50%">
          <stop offset="0%" stop-color="#f2e9c7" stop-opacity="1"/>
          <stop offset="42%" stop-color="#e6c384" stop-opacity="0.65"/>
          <stop offset="100%" stop-color="#c8c093" stop-opacity="0"/>
        </radialGradient>
        <radialGradient id="blueGlow" cx="50%" cy="50%" r="50%">
          <stop offset="0%" stop-color="#7fb4ca" stop-opacity="0.55"/>
          <stop offset="100%" stop-color="#7e9cd8" stop-opacity="0"/>
        </radialGradient>
        <linearGradient id="wave" x1="0" y1="0" x2="1" y2="0">
          <stop offset="0%" stop-color="#6a9589" stop-opacity="0.42"/>
          <stop offset="50%" stop-color="#7e9cd8" stop-opacity="0.56"/>
          <stop offset="100%" stop-color="#957fb8" stop-opacity="0.42"/>
        </linearGradient>
        <filter id="soft" x="-20%" y="-20%" width="140%" height="140%">
          <feGaussianBlur stdDeviation="28"/>
        </filter>
      </defs>

      <rect width="2560" height="1440" fill="url(#bg)"/>
      <circle cx="2110" cy="250" r="360" fill="url(#moon)" filter="url(#soft)"/>
      <circle cx="500" cy="1140" r="720" fill="url(#blueGlow)" filter="url(#soft)"/>
      <circle cx="2050" cy="1180" r="560" fill="#957fb8" opacity="0.22" filter="url(#soft)"/>

      <path d="M0 1010 C360 860 580 1060 910 930 C1240 800 1420 760 1720 850 C2010 936 2220 820 2560 720 L2560 1440 L0 1440 Z"
            fill="#151520" opacity="0.72"/>
      <path d="M0 1120 C340 1010 690 1160 1020 1035 C1330 916 1600 940 1850 1035 C2130 1140 2320 980 2560 930 L2560 1440 L0 1440 Z"
            fill="#1f2435" opacity="0.86"/>
      <path d="M0 1176 C390 1090 650 1215 1010 1130 C1330 1054 1690 1100 1980 1190 C2220 1265 2400 1190 2560 1150 L2560 1440 L0 1440 Z"
            fill="url(#wave)" opacity="1"/>

      <g opacity="0.36" stroke="#dcd7ba" stroke-width="1.8">
        <path d="M250 245 H450 M350 145 V345"/>
        <path d="M1880 430 H2060 M1970 340 V520"/>
        <path d="M760 610 H880 M820 550 V670"/>
      </g>

      <g opacity="0.42">
        <circle cx="360" cy="310" r="2.2" fill="#dcd7ba"/>
        <circle cx="620" cy="190" r="1.6" fill="#dcd7ba"/>
        <circle cx="980" cy="340" r="1.8" fill="#dcd7ba"/>
        <circle cx="1260" cy="210" r="1.4" fill="#dcd7ba"/>
        <circle cx="1480" cy="460" r="2" fill="#dcd7ba"/>
        <circle cx="1780" cy="160" r="1.6" fill="#dcd7ba"/>
        <circle cx="2250" cy="520" r="1.8" fill="#dcd7ba"/>
      </g>
    </svg>
  '';
}
