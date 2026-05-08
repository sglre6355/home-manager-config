{
  description = "sglre6355's Home Manager configuration";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-master,
      home-manager,
      nixvim,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      masterPkgs = import nixpkgs-master {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      homeConfigurations = {
        SGR-PCPA02 = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            ./hosts/sgr-pcpa02.nix
            nixvim.homeModules.nixvim
          ];

          extraSpecialArgs = {
            inherit masterPkgs;
          };
        };

        SGR-PCPB01 = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            ./hosts/sgr-pcpb01.nix
            nixvim.homeModules.nixvim
          ];

          extraSpecialArgs = {
            inherit masterPkgs;
          };
        };
      };
    };
}
