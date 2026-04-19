{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix  # железо, не трогать
  ];

  # ===== ЗАГРУЗЧИК =====
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # ===== СЕТЬ =====
  networking.hostName = "ideapad";
  networking.networkmanager.enable = true;

  # ===== ПОЛЬЗОВАТЕЛИ =====
  users.users.int = { # int = имя пользователя
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];  # wheel = доступ к sudo
  };
  security.sudo.wheelNeedsPassword = false;  # или true, если хочешь пароль

  # ===== ПАКЕТЫ =====
  environment.systemPackages = with pkgs; [
    git
  ];

  system.stateVersion = "25.05"; # это тоже не трогать
}
