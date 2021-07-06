{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.virtualisation;
  functionBlock = name: f: ''
    fallocate -l ${toString f.size}M   /dev/shm/${name};
    chown ${f.user}:${f.group}         /dev/shm/${name};
    chmod ${f.mode}                    /dev/shm/${name};
  '';
in {
  options.virtualisation.sharedMemoryFiles = mkOption {
    type = types.attrsOf (types.submodule ({ name, ... }: {
      options = {
        name = mkOption {
          visible = false;
          default = name;
          type = types.str;
        };
        size = mkOption {
          type = types.int;
          default = 0;
          description = "Size in MB.";
        };
        user = mkOption {
          type = types.str;
          default = "creator54";#"root";
          description = "Owner of the memory file";
        };
        group = mkOption {
          type = types.str;
          default = "wheel";#"root";
          description = "Group of the memory file";
        };
        mode = mkOption {
          type = types.str;
          default = "0600";
          description = "Group of the memory file";
        };
      };
    }));
    default = { };
  };

  config.system.activationScripts.sharedMemoryFiles = {
    text = concatStringsSep "\n"
      (mapAttrsToList (functionBlock) cfg.sharedMemoryFiles);
    deps = [ ];
  };
}
