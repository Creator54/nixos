{ config, pkgs, ... }:

  let
    stableTarball = fetchTarball https://releases.nixos.org/nixos/21.05/nixos-21.05.1076.bad3ccd099e/nixexprs.tar.xz;
    unstableTarball = fetchTarball https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz;
  in
  {
    nixpkgs.config = {
      packageOverrides = pkgs: {
        unstable = import unstableTarball {
          config = config.nixpkgs.config;
        };
      };
    };

    environment.systemPackages = with pkgs; [
      wget vim htop git kitty
    ];
  }
