# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #networking.hostName = "nixos"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  #networking.useDHCP = false;
  #networking.interfaces.enp0s20f0u1.useDHCP = true;
  #networking.interfaces.enp2s0.useDHCP = true;
  #networking.interfaces.wlp3s0.useDHCP = true;
  networking.networkmanager.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
   console = {
     font = "Lat2-Terminus16";
     keyMap = "us";
   };

  #Enable a Desktop Environment
  services.xserver.enable = true;
  #services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.defaultSession = "none+awesome";
  services.xserver.displayManager.startx.enable = true;
  services.xserver.windowManager = {
     awesome.enable = true;
     qtile.enable = true;
  };

  #Default Shell
  users.extraUsers.creator54 = {
	shell = pkgs.fish;
  };

  # Configure keymap in X11
   services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
   sound.enable = true;
   hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
   services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.creator54 = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" "gparted"]; # Enable ‘sudo’ for the user.
   };

  # Autologin
   services.mingetty.autologinUser = "creator54";
  # more info: https://github.com/NixOS/nixpkgs/blob/a6968ad43c1b6ab7fc341ddba4ed0a082a24229b/nixos/modules/profiles/installation-device.nix#L36

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
	
	# CLI tools
  	neofetch
  	wget
  	tmux
  	vim
  	fish
  	git
  	kitty
  	nnn
	htop
  	tlp
  	powertop
   	youtube-dl
   	awesome
	networkmanagerapplet
	efibootmgr
	scrot
     
  	# GUI tools
  	firefox
  	gparted
  	pcmanfm
	vscode-with-extensions
	sublime
	emacs
	dfilemanager
	xfe
	xfce.xfce4-screenshooter
  	
	#Window manager stuff
  	nitrogen
  	rofi
   	picom
   ];
  #Allow Properietry packages
  nixpkgs.config.allowUnfree = true;
  # Maintainence
  nix.gc.automatic = true; #runs nix-collect-garbage which removes old unrefrenced packages
  nix.gc.dates = "18:30";
  # nix-collect-garbage -d 
  # this removes old roots,removing the ability to rollback to them
  # for specific profiles
  # nix-env -p /nix/var/nix/profiles/per-user/creator54/profile --delete-generations old
  # more info: https://nixos.org/manual/nixos/stable/index.html#sec-changing-config
  # if nix-collect-garbage -d does not remove the entries 
  # manually remove entries from /boot/loader/entries/<entry>

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

