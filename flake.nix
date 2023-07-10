{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
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
                # (pkgs.terraform.overrideAttrs (oldAttrs: {
                #   version = "1.5.0"; # replace with your desired version
                #   src = pkgs.fetchurl {
                #     url = "https://releases.hashicorp.com/terraform/${oldAttrs.version}/terraform_${oldAttrs.version}_linux_amd64.zip";
                #     sha256 = "f25d764edfc89d0d7e42fb99be433558ae45d7a3";
                #   };
                # }))
                pkgs.fluxcd
                # (pkgs.fluxcd.overrideAttrs (oldAttrs: {
                # #     version = "2.0.0-rc.5";
                # #     sha256 = "1akxmnbldsm7h4wf40jxsn56njdd5srkr6a3gsi223anl9c43gpx";
                # #     manifestsSha256 = "1vra1vqw38r17fdkcj5a5rmifpdzi29z5qggzy4h9bqsqhxy488f";
                # }))
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
