{ config, pkgs, ... }:

let

  stableTarball = 
    fetchTarball
      https://releases.nixos.org/nixos/20.09/nixos-20.09.3087.2394284537b/nixexprs.tar.xz;
  unstableTarball =
    fetchTarball
      https://releases.nixos.org/nixpkgs/nixpkgs-21.03pre269485.a58a0b5098f/nixexprs.tar.xz;
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
    wget vim htop feh nox git unstable.dialog
    firefox
    kitty
    unstable.fortune
    unstable.capitaine-cursors
    unstable.bibata-extra-cursors
    unstable.papirus-maia-icon-theme
    adapta-gtk-theme #dark theme
    unstable.meld
    colorpicker
    nitrogen
    xorg.xf86videointel
    xorg.xf86inputmouse
    xorg.xf86inputkeyboard
    xorg.xf86inputlibinput
    xorg.xf86inputsynaptics
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

