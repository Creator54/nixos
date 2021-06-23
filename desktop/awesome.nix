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
        echo "exec awesome" >> ~/.xinitrc;
        if ! [[ -d ~/.config/awesome ]]
	        echo "getting your Awesome WM config ....";
	        echo
	        git clone https://github.com/creator54/awesome-configs -b new ~/.config/awesome;
        end
        startx &> /dev/null;
      end
    '';
  };
}

