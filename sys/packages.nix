{ config, pkgs, ... }:

{
  nixpkgs.overlays =
    let
      # Change this to a rev sha to pin
      moz-rev = "master";
      moz-url = builtins.fetchTarball { url = "https://github.com/mozilla/nixpkgs-mozilla/archive/${moz-rev}.tar.gz";};
      nightlyOverlay = (import "${moz-url}/firefox-overlay.nix");
    in [
      nightlyOverlay
    ];

  environment.systemPackages = with pkgs; [
    wget vim htop feh nox git
    latest.firefox-nightly-bin
    kitty
    fortune
    capitaine-cursors
    bibata-extra-cursors
    papirus-maia-icon-theme
    adapta-gtk-theme #dark theme
    meld
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

