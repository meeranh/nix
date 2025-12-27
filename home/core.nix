{ config, pkgs, lib, ... }:

{
  # ==========================================================================
  # ENVIRONMENT
  # ==========================================================================
  home.sessionVariables = {
    # QT dark mode
    QT_QPA_PLATFORMTHEME = "gtk3";
    QT_STYLE_OVERRIDE = "adwaita-dark";
    # Scaling
    QT_SCALE_FACTOR = "1.25";
    GDK_DPI_SCALE = "1.25";
    # Wayland/Sway
    XDG_CURRENT_DESKTOP = "sway";
    MOZ_ENABLE_WAYLAND = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    # Tools
    EDITOR = "nvim";
    GOPATH = "$HOME/.go";
    XKB_DEFAULT_OPTIONS = "caps:escape";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.local/share/nvim/mason/bin"
    "$HOME/.local/share/pnpm"
    "$HOME/.go/bin"
  ];

  # ==========================================================================
  # XDG
  # ==========================================================================
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = false;
      desktop = "$HOME/";
      documents = "$HOME/";
      download = "$HOME/";
      music = "$HOME/";
      pictures = "$HOME/";
      publicShare = "$HOME/";
      templates = "$HOME/";
      videos = "$HOME/";
    };
    mimeApps.enable = true;

    # Nvim config (will be replaced by nixvim later)
    configFile."nvim".source = ../nvim;
  };

  # ==========================================================================
  # GIT
  # ==========================================================================
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      pull.rebase = false;
      core.editor = "nvim";
    };
  };

  # ==========================================================================
  # DIRENV
  # ==========================================================================
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
