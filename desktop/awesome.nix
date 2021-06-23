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
    dmenu
    betterlockscreen
    networkmanagerapplet
    colorpicker
  ];


  # autostart on tty1 login
  programs.fish = {
    enable = true;
    loginShellInit = ''
      if test (id --user $USER) -ge 1000 && test (tty) = "/dev/tty1"
        if not test -d ~/.config/awesome
          clear;
          echo "Fetching your AWESOME Config .....";
          echo
          git clone https://github.com/creator54/awesome -b new ~/.config/awesome --depth=1;
        end
        echo "exec awesome" >> ~/.xinitrc;
#startx &> /dev/null;
      end
    '';
  };
}
