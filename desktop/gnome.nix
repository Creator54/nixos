{ config, pkgs, lib, ... }:

{
  services = {
    xserver = {
      displayManager = {
        defaultSession = "gnome";
	gdm.enable = true;
      };
      desktopManager.gnome3.enable = true;
    };
  };
}

