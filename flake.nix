{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    devenv.url = "github:cachix/devenv";
  };

  outputs = { self, nixpkgs, devenv, ... }@inputs:
    let
      systems = [
        "x86_64-linux"
        "i686-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      forAllSystems = f:
        builtins.listToAttrs (map (name: {
          inherit name;
          value = f name;
        }) systems);
    in {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt;
      devShells = forAllSystems (system:
        let pkgs = import nixpkgs { inherit system; };
        in {
          default = devenv.lib.mkShell {
            inherit inputs pkgs;
            modules = [{
              # https://devenv.sh/reference/options/
              packages = [
                pkgs.terraform
                pkgs.fluxcd
                pkgs.kubernetes-helm
                pkgs.kustomize
                #pkgs.kubernix
                pkgs.gnumake
                pkgs.github-cli
                pkgs.babashka
                pkgs.grafana-loki
                pkgs.kubectl
                pkgs.istioctl
                pkgs.just
                #pkgs.docker
              ];

              enterShell = ''
                export LOKI_ADDR="http://localhost:3100"
                # hello
              '';
            }];
          };
        });
    };
}
