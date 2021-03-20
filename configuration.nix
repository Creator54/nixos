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
    cleanTmpDir = true;
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

  #docker
  virtualisation.docker = {
    enable = true;
    extraOptions = "--config-file=${pkgs.writeText "daemon.json" (builtins.toJSON {
      graph ="/run/mount/data1/docker";
      storage-driver = "overlay";
    })}";
  };
  # https://stackoverflow.com/questions/24309526/how-to-change-the-docker-image-installation-directory
  # https://github.com/NixOS/nixpkgs/issues/68349

  # useraccount & properties
  users.users.creator54 = {
     isNormalUser = true;
     extraGroups = [ "docker" "power" "storage" "wheel" "audio" "video" "networkmanager" ];
     shell = pkgs.fish;
  };

  # Maintainence
  nix.gc.automatic = true; 				# runs nix-collect-garbage which removes old unrefrenced packages
  nix.gc.dates = "18:30";

  system.stateVersion = "20.09";
}


