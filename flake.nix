{
  description = "A collection of binaries for my neovim install";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};

      # Define your collection of binaries here
      myBinaries = [
        pkgs.neovim

        # Go
        pkgs.gopls
        pkgs.golangci-lint-langserver
        # pkgs.gci  # broken in nixos-unstable
        pkgs.gotools
        pkgs.golangci-lint
        pkgs.gofumpt

        # C compiler (for treesitter parser compilation)
        pkgs.gcc

        # Rust
        pkgs.rust-analyzer
        pkgs.rustfmt

        # Python
        pkgs.basedpyright
        pkgs.black

        # Terraform
        pkgs.opentofu
        pkgs.terraform-ls

        # TypeScript/JavaScript
        pkgs.typescript-language-server
        pkgs.nodejs_22

        # Angular
        pkgs.angular-language-server

        # Bash
        pkgs.bash-language-server

        # Lua
        pkgs.lua-language-server

        # Helm
        pkgs.helm-ls

        # Nix
        pkgs.alejandra
        pkgs.nixd

        # Protobuf
        pkgs.buf

        # Haskell
        pkgs.haskell-language-server

        # Tools
        pkgs.ripgrep
        pkgs.fd
        pkgs.git
        pkgs.tree-sitter
      ];
    in {
      # This creates a packages.default that includes all binaries
      packages.default = pkgs.symlinkJoin {
        name = "my-binaries";
        paths = myBinaries;
      };
    });
}
