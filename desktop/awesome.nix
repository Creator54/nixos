{ config, pkgs, lib, ... }:

{
  services = {
    xserver = {
      displayManager = {
        defaultSession = "none+awesome";
	startx.enable = true;
      };
      window.Manager.awesome.enable = true;
    };
  };
}

