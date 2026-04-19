{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix  # железо, не трогать
  ];

  # Загрузчик (UEFI)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Имя машины
  networking.hostName = "ideapad";

  # Пользователь
  users.users.int = { # int = имя пользователя
    isNormalUser = true;
    extraGroups = [ "wheel" ];  # wheel = доступ к sudo
    initialPassword = "changeme"; # изначальный пароль
  };

  # Без этого нельзя стать root
  security.sudo.wheelNeedsPassword = false;  # или true, если хочешь пароль

  system.stateVersion = "25.05"; # это тоже не трогать
}
