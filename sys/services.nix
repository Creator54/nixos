{ config, pkgs, lib, ... }:

{
  # services that i need
  services = {
    xserver = {
      enable = true;
      layout = "us";
      libinput.enable = true; 				# touchpad support generally enabled by most display managers
    };

    udev.extraRules = lib.mkMerge [
      # autosuspend USB devices
      ''ACTION=="add", SUBSYSTEM=="usb", TEST=="power/control", ATTR{power/control}="auto"''
      # autosuspend PCI devices
      ''ACTION=="add", SUBSYSTEM=="pci", TEST=="power/control", ATTR{power/control}="auto"''
      # disable Ethernet Wake-on-LAN
      ''ACTION=="add", SUBSYSTEM=="net", NAME=="enp*", RUN+="${pkgs.ethtool}/sbin/ethtool -s $name wol d"''
    ];

    # https://discourse.nixos.org/t/thinkpad-t470s-power-management/8141/4
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_BAT="powersave";
        CPU_SCALING_GOVERNOR_ON_AC="performance";

        # The following prevents the battery from charging fully to
        # preserve lifetime. Run `tlp fullcharge` to temporarily force
        # full charge.
        # https://linrunner.de/tlp/faq/battery.html#how-to-choose-good-battery-charge-thresholds
        START_CHARGE_THRESH_BAT0=40;
        STOP_CHARGE_THRESH_BAT0=50;

        # 100 being the maximum, limit the speed of my CPU to reduce
        # heat and increase battery usage:
        CPU_MAX_PERF_ON_AC=100;
        CPU_MAX_PERF_ON_BAT=30;
	SOUND_POWER_SAVE_ON_AC=0;
        SOUND_POWER_SAVE_ON_BAT=1;
      };
    };

    mingetty.autologinUser = "creator54";
    thermald.enable = true;
    upower.enable = true;
    # https://github.com/NixOS/nixos-hardware/blob/master/common/pc/laptop/hdd/default.nix
    # Hard disk protection if the laptop falls:
    hdapsd.enable = lib.mkDefault true;
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

  sound.enable = true;
}

