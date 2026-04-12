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

      tree-sitter-new = pkgs.tree-sitter.overrideAttrs (old: rec {
        version = "0.26.1";
        src = pkgs.fetchFromGitHub {
          owner = "tree-sitter";
          repo = "tree-sitter";
          tag = "v${version}";
          hash = "sha256-k8X2qtxUne8C6znYAKeb4zoBf+vffmcJZQHUmBvsilA=";
          fetchSubmodules = true;
        };
        patches = [];
        cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
          inherit src;
          hash = "sha256-hnFHYQ8xPNFqic1UYygiLBWu3n82IkTJuQvgcXcMdv0=";
        };
        nativeBuildInputs =
          old.nativeBuildInputs
          ++ [
            pkgs.llvmPackages.libclang
            pkgs.stdenv.cc
            pkgs.glibc.dev
          ];
        LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.lib}/lib";
        BINDGEN_EXTRA_CLANG_ARGS = "-isystem ${pkgs.glibc.dev}/include -isystem ${pkgs.stdenv.cc.cc}/include";
      });

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
        tree-sitter-new # replaced pkgs.tree-sitter
      ];
    in {
      packages.default = pkgs.symlinkJoin {
        name = "my-binaries";
        paths = myBinaries;
      };
    });
}
