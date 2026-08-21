{
  description = "sglre6355's Home Manager configuration";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    llm-agents.url = "github:numtide/llm-agents.nix";
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs =
    {
      nixpkgs,
      llm-agents,
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
            llmAgentsPkgs = llm-agents.packages.${system};
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

        "intern595@intern595noMacBook-Pro" = mkHome {
          system = "aarch64-darwin";
          host = ./hosts/intern595noMacBook-Pro.nix;
        };

        "keima_hara@m-stony" = mkHome {
          system = "aarch64-darwin";
          host = ./hosts/m-stony.nix;
        };
      };
    };
}
