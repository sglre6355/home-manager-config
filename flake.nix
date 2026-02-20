{
  description = "Home Manager configuration of sglre6355";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-master,
      home-manager,
      nur,
      nixvim,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          nur.overlays.default
        ];
      };
      masterPkgs = import nixpkgs-master {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      homeConfigurations."sglre6355" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./home.nix
          ./work.nix
          nixvim.homeModules.nixvim
        ];

        extraSpecialArgs = {
          inherit masterPkgs;
        };
      };
    };
}
