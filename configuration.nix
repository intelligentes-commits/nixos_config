{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix  # железо, не трогать
  ];

  # ===== ЗАГРУЗЧИК =====
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # ===== СЕТЬ =====
  networking.hostName = "ideapad";
  networking.networkmanager.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  # ===== ПОЛЬЗОВАТЕЛИ =====
  users.users.int = { # int = имя пользователя
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" ];  # wheel = доступ к sudo
  };
  security.sudo.wheelNeedsPassword = false;  # или true, если хочешь пароль

  # ===== ПАКЕТЫ =====
  programs.fish.enable = true;
  programs.amnezia-vpn.enable = true;

  environment.systemPackages = with pkgs; [
    git
  ];
  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];

  # ===== DISPLAY MANAGER =====
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd niri-session";
        user = "greeter";
      };
    };
  };

  # Для хранения паролей (wifi, ssh ключи и т.д.)
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greeter.enableGnomeKeyring = true;
  programs.dconf.enable = true;

  system.stateVersion = "25.05"; # это тоже не трогать
}
