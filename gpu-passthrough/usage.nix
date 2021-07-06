{
  hardware.pulseaudio.extraConfig = ''
    # Local socket for QEMU
    load-module module-native-protocol-unix auth-anonymous=1 socket=/tmp/pulse-socket
  '';

  virtualisation = {
    sharedMemoryFiles = {
      looking-glass = {
        size = 32; # Needs to be a power of 2 for looking-glass
        user = "root";
        group = "root";
        mode = "666";
      };
    };
    libvirtd = {
      enable = true;
      qemuOvmf = true;
      clearEmulationCapabilities = false;
      deviceACL = [
        "/dev/input/by-path/pci-0000:00:14.0-usb-0:6.3:1.0-event-mouse" # Trackball
        "/dev/input/by-path/pci-0000:00:14.0-usb-0:6.1:1.0-event-kbd" # Keyboard
        "/dev/input/by-path/pci-0000:00:14.0-usb-0:6.1:1.1-event-kbd" # Keyboard
        "/dev/input/by-path/pci-0000:00:14.0-usb-0:6.1:1.1-event" # Keyboard
        "/dev/vfio/vfio"
        "/dev/vfio/14"
        "/dev/vfio/15"
        "/dev/kvm"
        "/dev/shm/looking-glass"
      ];
    };
    vfio = {
      enable = true;
      IOMMUType = "intel";
      devices = [ "10de:1d10" ]; #get PCI ids via lspci -nn 8086:9d71
      blacklistNvidia = true;
      disableEFIfb = true;
      ignoreMSRs = true;
      applyACSpatch = true;
    };
  };
}
