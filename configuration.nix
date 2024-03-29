{ config, pkgs, ... }:

{
  imports =
    [ 
      ./sys/hardware.nix
      ./sys/packages.nix
      ./sys/services.nix
      #./sys/kernel.nix
      #./sys/plymouth.nix
      #./sys/docker.nix
      ./sys/nvidia.nix
      ./vm-configs/virt-manager.nix
      #./vm-configs/virtualbox.nix
      ./desktop/awesome.nix
    ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      timeout = 5;
      efi.canTouchEfiVariables = true;
    };
    cleanTmpDir = true;
  };

  # networking
  networking = {
    networkmanager.enable = true;
    hostName = "CosPi";
    nameservers = ["8.8.4.4" "8.8.8.8" "1.1.1.1" "9.9.9.9"]; #without this will have to add nameserves to /etc/resolv.conf , internet fails without this on chroot, should be declared since not using dhcp
  };
  
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
    earlySetup = true;
  };

  # useraccount & properties
  users = {
    users.creator54 = {
       isNormalUser = true;
       extraGroups = [ "power" "storage" "wheel" "audio" "video" "networkmanager" ];
       shell = pkgs.fish;
    };
  };
 
  security.allowSimultaneousMultithreading = true;

  #services.openssh.enable = true;
  # Maintainence
  nix.gc = {
    automatic = true; 				# runs nix-collect-garbage which removes old unrefrenced packages
    dates = "18:30";
  };

  time.hardwareClockInLocalTime = true;
  system.stateVersion = "21.05";
}

