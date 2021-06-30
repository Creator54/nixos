{ config, pkgs, ... }:

{
  imports =
    [ 
      ./sys/hardware.nix
      ./sys/packages.nix
      ./sys/services.nix
      #./sys/plymouth.nix
      #./sys/docker.nix
      #./sys/nvidia.nix
      #./vm-configs/virt-manager.nix
      #./vm-configs/virtualbox.nix
      ./desktop/awesome.nix
    ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      timeout = 0;
      efi.canTouchEfiVariables = true;
    };
    cleanTmpDir = true;
  };

  # networking
  networking = {
    networkmanager.enable = true;
    hostName = "CosPi";
    nameservers = ["1.1.1.1" "9.9.9.9"]; #without this will have to add nameserves to /etc/resolv.conf , internet fails without this
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

  services.openssh.enable = true;
  # Maintainence
  nix.gc.automatic = true; 				# runs nix-collect-garbage which removes old unrefrenced packages
  nix.gc.dates = "18:30";

  system.stateVersion = "20.09";
}


