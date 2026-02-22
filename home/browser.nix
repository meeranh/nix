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

        # Compact sidebar
        "zen.view.compact" = true;
        "zen.view.compact.enable-at-startup" = true;
        "zen.view.compact.show-sidebar-and-toolbar-on-hover" = true;
        "zen.view.sidebar-expanded" = false;
        "zen.view.sidebar-expanded.max-width" = 300;
        "zen.view.use-single-toolbar" = false;
        "zen.workspaces.show-icon-strip" = true;
        "zen.welcome-screen.seen" = true;
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
