{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.fileserver_load;
in
{

  ###### interface
  meta.maintainers = [ maintainers.augu5te ];

  options = {
    services.fileserver_load = {

      enable = mkEnableOption "Fileserver Load";
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
    systemd.services.fileserver_load = {
      description = "Fileserver Load";
      wantedBy = [ "multi-user.target" ];
      before = [ "config.services.my-startup" ];
      after = [ "network.target"];
      path = cfg.path;
      # serviceConfig.Type = "oneshot";
      script = cfg.script;
    };
  };
}
