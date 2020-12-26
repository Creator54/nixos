{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/2f992723-4a2c-4d7b-a6ae-bcb0a7fbdded";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/71C6-3FFC";
      fsType = "vfat";
    };

  fileSystems."/media/data" =
    { device = "/dev/disk/by-uuid/c5a7dad5-deaa-4a06-ab8b-b4f48c619fe2";
      fsType = "ext4";
    };

  swapDevices = [ { device = "/swapfile"; size = 4096; } ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
