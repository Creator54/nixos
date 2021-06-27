{ config, pkgs, ... }:

{
  services = {
    xserver = {
      desktopManager = {
        pantheon.enable = true;
        # pantheon.extraWingpanelIndicators
        # pantheon.extraSwitchboardPlugs 
      };
      #displayManager.lightdm = {
      #  enable = true;
      #  greeters.pantheon.enable = false;
      #};
    };
    pantheon.apps.enable = false; 
  };
}
