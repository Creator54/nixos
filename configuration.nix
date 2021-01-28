{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./sys/hardware.nix
      ./sys/packages.nix
      ./sys/services.nix
      #./sys/nvidia.nix
      ./desktop/awesome.nix
    ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      timeout = 0;
      efi.canTouchEfiVariables = true;
    };
    #kernelParams = ["quiet" ];
    #consoleLogLevel = 4;
    #plymouth.enable = true;
  };

  # networking
  networking = {
    networkmanager.enable = true;
    hostName = "CosPi";
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
  users.users.creator54 = {
     isNormalUser = true;
     extraGroups = [ "power" "storage" "wheel" "audio" "video" "networkmanager" ];
     shell = pkgs.fish;
  };

  # Maintainence
  nix.gc.automatic = true; 				# runs nix-collect-garbage which removes old unrefrenced packages
  nix.gc.dates = "18:30";

  system.stateVersion = "20.09";
}


