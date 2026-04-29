{
  description = "A collection of binaries for my neovim install";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-23-11.url = "github:NixOS/nixpkgs/nixos-23.11";
    zls.url = "github:zigtools/zls";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-23-11,
    zls,
  }: let
    systems = ["x86_64-linux" "aarch64-darwin"];

    forEachSystem = f:
      builtins.listToAttrs (map (system: {
          name = system;
          value = f system;
        })
        systems);
  in {
    packages = forEachSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-23-11 = import nixpkgs-23-11 {localSystem = system;};

      pinnedPkgs = {
        gci = pkgs.buildGoModule.override {go = pkgs-23-11.go_1_21;} rec {
          pname = "gci";
          version = "0.13.6";

          src = pkgs.fetchFromGitHub {
            owner = "daixiang0";
            repo = pname;
            rev = "v${version}";
            hash = "sha256-BlR7lQnp9WMjSN5IJOK2HIKXIAkn5Pemf8qbMm83+/w=";
          };

          vendorHash = "sha256-/8fggERlHySyimrGOHkDERbCPZJWqojycaifNPF6MjE=";
        };

        tree-sitter = pkgs.tree-sitter.overrideAttrs (old:
          rec {
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
              ]
              ++ pkgs.lib.optionals pkgs.stdenv.hostPlatform.isLinux [
                pkgs.glibc.dev
              ];
            LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.lib}/lib";
          }
          // pkgs.lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
            BINDGEN_EXTRA_CLANG_ARGS = "-isystem ${pkgs.glibc.dev}/include -isystem ${pkgs.stdenv.cc.cc}/include";
          });
      };

      myBinaries = [
        pkgs.neovim

        # Go
        pkgs.gopls
        pkgs.golangci-lint-langserver
        pkgs.gotools
        pinnedPkgs.gci
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

        # Zig
        zls.packages.${system}.zls

        # Tools
        pkgs.ripgrep
        pkgs.fd
        pkgs.git
        pinnedPkgs.tree-sitter
      ];
    in {
      default = pkgs.symlinkJoin {
        name = "my-binaries";
        paths = myBinaries;
      };
    });
  };
}
