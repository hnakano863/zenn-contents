{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.05";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.zenn.url = "github:hnakano863/nix-zenn-cli";

  outputs = { self, nixpkgs, flake-utils, zenn }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ zenn.overlay ];
        };
      in
        {
          devShell = with pkgs; mkShell {
            buildInputs = [ zenn-cli.${system} ];
          };
        }
    );
}
