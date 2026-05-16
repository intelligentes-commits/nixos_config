{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "ideapad";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Moscow";

  services.xserver.xkb = {
    layout = "us,ru";
    options = "grp:caps_toggle";
  };
  console.useXkbConfig = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  users.users.int = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" ];
  };
  security.sudo.wheelNeedsPassword = false;

  programs.fish.enable = true;
  programs.amnezia-vpn.enable = true;

  environment.systemPackages = with pkgs; [
    git
  ];
}
