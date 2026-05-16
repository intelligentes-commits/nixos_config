{ pkgs, helium, ... }:

{
  home.packages = with pkgs; [
    codex
    helium.packages.x86_64-linux.default
    eza
    ffmpegthumbnailer
    fd
    grim
    imagemagick
    libnotify
    localsend
    mako
    brightnessctl
    playerctl
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
    awww
    telegram-desktop
    unrar
    unzip
    xdg-utils
    yazi
    zed-editor
    zip
  ];

  fonts.fontconfig.enable = true;
}
