{lib, ...}: let
  locale = "en_US.UTF-8";
  default = lib.mkDefault locale;
in {
  time.timeZone = lib.mkDefault "America/Los_Angeles";
  i18n.defaultLocale = default;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = default;
    LC_IDENTIFICATION = default;
    LC_MEASUREMENT = default;
    LC_MONETARY = default;
    LC_NAME = default;
    LC_NUMERIC = default;
    LC_PAPER = default;
    LC_TELEPHONE = default;
    LC_TIME = default;
  };
}
