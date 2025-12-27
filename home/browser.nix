{ config, pkgs, lib, inputs, ... }:

{
  programs.zen-browser = {
    enable = true;

    policies = {
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DontCheckDefaultBrowser = true;
      ExtensionSettings = {};
    };

    profiles.default = {
      name = "default";
      isDefault = true;
      settings = {
        "browser.startup.homepage_override.mstone" = "ignore";
        "privacy.sanitize.sanitizeOnShutdown" = false;
        "privacy.clearOnShutdown.cookies" = false;
        "privacy.clearOnShutdown.sessions" = false;
        "extensions.autoDisableScopes" = 0;
      };
      extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
        ublock-origin
        bitwarden
        darkreader
        vimium-c
      ];
    };
  };

  # Set Zen as default browser
  xdg.mimeApps.defaultApplications = {
    "text/html" = "zen.desktop";
    "x-scheme-handler/http" = "zen.desktop";
    "x-scheme-handler/https" = "zen.desktop";
    "x-scheme-handler/about" = "zen.desktop";
    "x-scheme-handler/unknown" = "zen.desktop";
  };
}
