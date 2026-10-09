{
  description = "A collection of binaries for my neovim install";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-26-05.url = "github:NixOS/nixpkgs/nixos-26.05";
    zls.url = "github:zigtools/zls";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-26-05,
    nixpkgs-unstable,
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
      pkgs-26-05 = nixpkgs-26-05.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};

      myBinaries = [
        pkgs-unstable.neovim

        # Go
        pkgs.gopls
        pkgs.golangci-lint-langserver
        pkgs.gotools
        pkgs.gci # 0.13.6 ships in nixos-25.05 natively
        pkgs.golangci-lint
        pkgs.gofumpt

        # C compiler (for treesitter parser compilation)
        pkgs.gcc

        # Rust
        # NOTE: rust-analyzer and rustfmt live in profiles/rust.nix alongside rustc/cargo
        # to avoid ABI mismatches — they must come from the same pkgs instance

        # Python
        pkgs.basedpyright
        pkgs.black

        # Terraform
        pkgs.opentofu
        pkgs.terraform-ls

        # TypeScript/JavaScript
        # NOTE: nodejs comes from profiles (web.nix), not bundled here to avoid conflicts
        pkgs.typescript-language-server

        # Angular
        pkgs.angular-language-server

        # Bash
        pkgs.bash-language-server

        # Lua
        pkgs-26-05.emmylua-ls
        pkgs-26-05.emmylua-formatter

        # Helm
        pkgs.helm-ls

        # KCL
        pkgs.kittycad-kcl-lsp

        # Nix
        pkgs.alejandra
        pkgs.nixd

        # Protobuf
        pkgs-unstable.buf

        # Haskell
        # NOTE: haskell-language-server, ghc, cabal-install all live in profiles/haskell.nix
        # HLS is compiled against a specific GHC ABI — they MUST come from the same pkgs instance

        # Zig
        zls.packages.${system}.zls

        # Tools
        # NOTE: fd and ripgrep come from profiles (cli.nix) to avoid profile collisions
        # If using nvim without profiles installed, add them back here
        pkgs.tree-sitter # 0.25.3 in nixos-25.05, compatible with rustc 1.86.0
      ];
    in {
      default = pkgs.symlinkJoin {
        name = "my-binaries";
        paths = myBinaries;
      };
    });
  };
}
