{ config, pkgs, lib, inputs, ... }:

{
  home.username = "neo";
  home.homeDirectory = "/home/neo";
  home.stateVersion = "24.11";

  # Let home-manager manage itself
  programs.home-manager.enable = true;

  # ==========================================================================
  # DOTFILES (all config files are in this repo)
  # ==========================================================================
  xdg.configFile = {
    "nvim".source = ./nvim;
    "sway".source = ./dotfiles/sway;
    "fish".source = ./dotfiles/fish;
    "foot".source = ./dotfiles/foot;
    "wofi".source = ./dotfiles/wofi;
    "dunst".source = ./dotfiles/dunst;
    "yambar".source = ./dotfiles/yambar;
    "starship.toml".source = ./dotfiles/starship.toml;
    "scripts".source = ./dotfiles/scripts;
    "wallpapers".source = ./dotfiles/wallpapers;
  };

  # ==========================================================================
  # GTK THEME (Dark mode)
  # ==========================================================================
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  # Dark mode for QT apps
  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "gtk3";
    QT_STYLE_OVERRIDE = "adwaita-dark";
  };

  # ==========================================================================
  # XDG
  # ==========================================================================
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
    mimeApps.enable = true;
  };

  # ==========================================================================
  # PROGRAMS (minimal - most config comes from dotfiles)
  # ==========================================================================

  # Git (no email/name - you set per-repo)
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      pull.rebase = false;
      core.editor = "nvim";
    };
  };

  # Direnv for auto-activating nix shells
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # ==========================================================================
  # ZEN BROWSER
  # ==========================================================================
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
        surfingkeys
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
