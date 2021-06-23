{ config, pkgs, lib, ... }:

{
  services = {
    xserver = {
      displayManager = {
        defaultSession = "none+awesome";
	      startx.enable = true;
      };
      windowManager.awesome.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    rofi dialog
    betterlockscreen
    networkmanagerapplet
    colorpicker
  ];


  # autostart on tty1 login
  programs.fish = {
    enable = true;
    loginShellInit = ''
      if test (id --user $USER) -ge 1000 && test (tty) = "/dev/tty1"
	      exec /etc/nixos/desktop/autostart
      end
    '';
  };
}

