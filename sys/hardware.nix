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
    #kernelPackages = pkgs.linuxPackages_latest;

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
    { device = "/dev/sda2";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/sda1";
      fsType = "vfat";
    };

  swapDevices = [ { device = "/swapfile"; size = 4096; } ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
