{ ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake /home/int/nixos_config#ideapad";
      nrt = "sudo nixos-rebuild test --flake /home/int/nixos_config#ideapad";
      nrb = "sudo nixos-rebuild boot --flake /home/int/nixos_config#ideapad";
      ncheck = "nix flake check /home/int/nixos_config";
      nup = "nix flake update --flake /home/int/nixos_config";

      cat = "bat";
      ls = "eza --icons --group-directories-first";
      ll = "eza -la --icons --group-directories-first";
      la = "eza -a --icons --group-directories-first";
      grep = "rg";
      wall = "awww img --transition-type any --transition-duration 1";
      y = "yazi";
    };
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.bat.enable = true;
}
