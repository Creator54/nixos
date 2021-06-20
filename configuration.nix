{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./sys/hardware.nix
      ./sys/packages.nix
      ./sys/services.nix
      ./sys/docker.nix
      ./sys/nvidia.nix
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

  # useraccount & properties
  users = {
    users.creator54 = {
       isNormalUser = true;
       extraGroups = [ "libvirtd" "docker" "power" "storage" "wheel" "audio" "video" "networkmanager" ];
       shell = pkgs.fish;
    };
    extraGroups.vboxusers.members = [ "creator54" ];
  };

  virtualisation = {
    virtualbox.host.enable = true;
    libvirtd = {
      enable = true;
    };
  };
  services.openssh.enable = true;
  # Maintainence
  nix.gc.automatic = true; 				# runs nix-collect-garbage which removes old unrefrenced packages
  nix.gc.dates = "18:30";

  system.stateVersion = "20.09";
}


