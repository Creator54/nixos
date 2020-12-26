{ config, pkgs, ... }:

{
  # services that i need
  services = {
    xserver = {
      enable = true;
      layout = "us";
      libinput.enable = true; 				# touchpad support generally enabled by most display managers
      displayManager = {
        defaultSession = "none+awesome";
        startx.enable = true;
      };
      windowManager = {
	awesome.enable = true;
      };
    };

    mingetty.autologinUser = "creator54";
    thermald.enable = true;
    tlp.enable = true;
    # printing.enable = true; 				# enables CUPS for printing
  };
  
  # systemd services which i dont like/use mostly cuz increases boot time and i find no issues not having them
  systemd.services = {
    systemd-udev-settle.enable = false;			
    NetworkManager-wait-online.enable = false;
    firewall.enable = false;
    systemd-journal-flush.enable = false;
    lvm2-activation-early.enable = false;
    lvm2-activation.enable = false;
  };

  # light works even without an xsession
  programs.light.enable = true;
  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 10"; }
      { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 10"; }
    ];
  };

  # autostart on tty1 login
  programs.fish = {
    enable = true;
    loginShellInit = ''
      if test (id --user $USER) -ge 1000 && test (tty) = "/dev/tty1"
        exec /etc/nixos/sys/autostart
      end
    '';
  };
}

