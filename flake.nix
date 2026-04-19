{
  decription = "йоу";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helium = {
      url = "github:schembriaiden/helium-browser-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, niri, helium, ... }: {
    nixosConfigurations.ideapad = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        .configuration.nix
        niri.nixosModules.niri
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.int = import ./home.nix;
          home-manager.sharedModules = [ niri.homeModules.niri ];
          home-manager.extraSpecialArgs = { inherit helium; };
        }
      ];
    };
  };
}
