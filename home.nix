{ config, pkgs, lib, inputs, ... }:

{
  home.username = "neo";
  home.homeDirectory = "/home/neo";
  home.stateVersion = "24.11";

  # Let home-manager manage itself
  programs.home-manager.enable = true;

  # ==========================================================================
  # DOTFILES SYMLINKS
  # Clone these repos first:
  #   git clone https://github.com/meeranh/dotfiles ~/dotfiles
  #   git clone https://github.com/meeranh/BlazeVim ~/BlazeVim
  # ==========================================================================
  xdg.configFile = {
    "nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/neo/BlazeVim";
    "sway".source = config.lib.file.mkOutOfStoreSymlink "/home/neo/dotfiles/sway";
    "fish".source = config.lib.file.mkOutOfStoreSymlink "/home/neo/dotfiles/fish";
    "foot".source = config.lib.file.mkOutOfStoreSymlink "/home/neo/dotfiles/foot";
    "wofi".source = config.lib.file.mkOutOfStoreSymlink "/home/neo/dotfiles/wofi";
    "dunst".source = config.lib.file.mkOutOfStoreSymlink "/home/neo/dotfiles/dunst";
    "yambar".source = config.lib.file.mkOutOfStoreSymlink "/home/neo/dotfiles/yambar";
    "starship.toml".source = config.lib.file.mkOutOfStoreSymlink "/home/neo/dotfiles/starship.toml";
    "scripts".source = config.lib.file.mkOutOfStoreSymlink "/home/neo/dotfiles/scripts";
    "wallpapers".source = config.lib.file.mkOutOfStoreSymlink "/home/neo/dotfiles/wallpapers";
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
}
