{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" ];
    initrd.kernelModules = [ "i915" ];
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
    kernelPackages = pkgs.linuxPackages_latest;

    # https://discourse.nixos.org/t/thinkpad-t470s-power-management/8141
    extraModprobeConfig = lib.mkMerge [
      # idle audio card after one second
      "options snd_hda_intel power_save=1"
      # enable wifi power saving (keep uapsd off to maintain low latencies)
      "options iwlwifi power_save=1 uapsd_disable=1"
    ];

    # https://github.com/NixOS/nixpkgs/issues/18356
    blacklistedKernelModules = [ "nouveau" ];
    
    kernelParams = [
      "i915.enable_fbc=1"
      "i915.enable_psr=2"
      "intel_pstate=disable"
    ];
  };

  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    opengl.driSupport32Bit = true;
    opengl.extraPackages = with pkgs; [
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-media-driver
    ];
    pulseaudio.enable = true;
    pulseaudio.support32Bit = true;
  };

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
