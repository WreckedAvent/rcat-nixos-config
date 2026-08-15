{pkgs, ...}: {
  services.ollama = {
    enable = true;
    package = pkgs.ollama-rocm;
    loadModels = ["qwen3.6"];
  };

  environment.systemPackages = [
    pkgs.opencode
    pkgs.claude-code
  ];
}
