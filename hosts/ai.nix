{pkgs, ...}: {
  services.ollama = {
    enable = true;
    package = pkgs.ollama-rocm;
    loadModels = ["qwen3.6"];
    environmentVariables = {
      OLLAMA_CONTEXT_LENGTH = "256000";
    };
  };

  environment.systemPackages = [
    pkgs.opencode
    pkgs.claude-code
  ];
}
