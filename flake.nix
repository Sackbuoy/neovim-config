{
  description = "A collection of binaries for my neovim install";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        
        # Define your collection of binaries here
        myBinaries = [
          pkgs.neovim

          pkgs.gopls
          pkgs.golangci-lint-langserver
          pkgs.gci
          pkgs.gotools
          pkgs.golangci-lint

	  pkgs.gcc11

          pkgs.rust-analyzer
          pkgs.rustfmt

          pkgs.pylyzer
          pkgs.black

          pkgs.terraform
          pkgs.terraform-ls

          pkgs.typescript-language-server

          pkgs.angular-language-server

          pkgs.bash-language-server

          pkgs.lua-language-server

          pkgs.helm-ls

          pkgs.ripgrep
        ];
      in
      {
        # This creates a packages.default that includes all binaries
        packages.default = pkgs.symlinkJoin {
          name = "my-binaries";
          paths = myBinaries;
        };
      });
}

