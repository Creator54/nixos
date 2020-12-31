{ config, pkgs, ... }:

let

  stableTarball = 
    fetchTarball
      https://releases.nixos.org/nixos/20.09/nixos-20.09.2382.ca119749d86/nixexprs.tar.xz;
  unstableTarball =
    fetchTarball
      https://releases.nixos.org/nixpkgs/nixpkgs-21.03pre259358.b67ba0bfcc7/nixexprs.tar.xz;
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
    wget vim htop nox git rofi unstable.dialog
    firefox
    kdeconnect
    dolphin
    kitty
    networkmanagerapplet
    unstable.meld
    unstable.xfce.mousepad
    adapta-gtk-theme #dark theme
    kdeFrameworks.breeze-icons # icons for dolphin,meld etc
    lxappearance-gtk2 # for setting icons
    colorpicker
    xfce.xfce4-screenshooter
    nitrogen
  ];
  
  # Some fonts
   fonts.fonts = with pkgs; [
     fira-code fira-code-symbols
     cascadia-code
     source-code-pro
     twemoji-color-font
   ];

  # Allow Properietry packages
  nixpkgs.config.allowUnfree = true;
}

# https://stackoverflow.com/questions/48831392/how-to-add-nixos-unstable-channel-declaratively-in-configuration-nix
# https://channels.nixos.org/

