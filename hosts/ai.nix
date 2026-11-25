{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.rcat.ai;
  inherit (lib) mkEnableOption mkIf;
in {
  options.rcat.ai = {
    enable = mkEnableOption "all SI features";
  };

  config = mkIf cfg.enable {
    services.ollama = {
      enable = true;
      package = pkgs.ollama-rocm;
      loadModels = ["qwen3.6" "ornith1.5"];
      environmentVariables = {
        OLLAMA_CONTEXT_LENGTH = "256000";
      };
    };

    environment.systemPackages = [
      pkgs.opencode
      pkgs.claude-code
    ];
  };
}
