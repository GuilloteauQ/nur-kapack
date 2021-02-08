{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.oar-profile;
in
{

  ###### interface
  meta.maintainers = [ maintainers.augu5te ];

  options = {
    services.oar-profile = {

      enable = mkEnableOption "OAR Profile";
      script =  mkOption {
          type = types.str;
          default = "/srv/cigri/cigri-expe/misc/remote_loadavg_sensor.sh";
          description = "Script File to execute a start time";
      };

      path =  mkOption {
        type = types.path;
        default = [ ];
        description = "Path to tools used by provided script";
      };
    };
  };

  ###### implementation
  config =  mkIf ( cfg.enable)  {
    systemd.services.oar-profile = {
      description = "OAR Profile";
      wantedBy = [ "multi-user.target" ];
      # after = [ "config.services.my-startup" ];
      path = cfg.path;
      # serviceConfig.Type = "oneshot";
      script = cfg.script;
      serviceConfig = {
        Type = "simple";
        # User = "cigri";
        TimeoutSec = "infinity";
        KillMode = "process";
        Restart = "on-failure";
      };
    };
  };
}
