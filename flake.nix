{
  description = "sglre6355's Home Manager configuration";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixvim.url = "github:nix-community/nixvim";
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
      mkHome =
        { system, host }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };

          modules = [
            host
            nixvim.homeModules.nixvim
          ];

          extraSpecialArgs = {
            masterPkgs = import nixpkgs-master {
              inherit system;
              config.allowUnfree = true;
            };
          };
        };
    in
    {
      homeConfigurations = {
        "sglre6355@SGR-PCPA02" = mkHome {
          system = "x86_64-linux";
          host = ./hosts/sgr-pcpa02.nix;
        };

        "sglre6355@SGR-PCPB01" = mkHome {
          system = "x86_64-linux";
          host = ./hosts/sgr-pcpb01.nix;
        };
      };
    };
}
