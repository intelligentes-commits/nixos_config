{ pkgs, ... }:

let
  theme = import ./theme.nix;
  dark = theme.name == "dusk";
  gtkThemeName = if dark then "adw-gtk3-dark" else "adw-gtk3";
  colorScheme = if dark then "prefer-dark" else "prefer-light";
in

{
  gtk = {
    enable = true;

    theme = {
      name = gtkThemeName;
      package = pkgs.adw-gtk3;
    };

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = dark;
    };

    gtk4.theme = {
      name = gtkThemeName;
      package = pkgs.adw-gtk3;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = dark;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style = {
      name = if dark then "adwaita-dark" else "adwaita";
      package = pkgs.adwaita-qt;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = colorScheme;
      gtk-theme = gtkThemeName;
      icon-theme = "Adwaita";
      cursor-theme = "Bibata-Modern-Classic";
      cursor-size = 20;
    };

    "org/freedesktop/appearance" = {
      color-scheme = if dark then 1 else 2;
    };
  };
}
