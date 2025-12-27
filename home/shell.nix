{ config, pkgs, lib, wallpapers, ... }:

{
  # ==========================================================================
  # FISH
  # ==========================================================================
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      # Disable greeting
      set -g fish_greeting

      # Vi keybindings
      fish_vi_key_bindings

      # Syntax highlighting colors (Tokyo Night)
      set -g fish_color_normal normal
      set -g fish_color_command blue
      set -g fish_color_quote yellow
      set -g fish_color_redirection cyan
      set -g fish_color_end green
      set -g fish_color_error red
      set -g fish_color_param cyan
      set -g fish_color_comment brblack
      set -g fish_color_selection white --bold --background=brblack
      set -g fish_color_operator cyan
      set -g fish_color_escape yellow
      set -g fish_color_autosuggestion brblack
    '';

    shellAliases = {
      # File management
      open = "xdg-open";
      rm = "trash";
      l = "ls --color=auto";
      f = "yazi";

      # Editors
      v = "nvim";
      nv = "nvim";
      vim = "nvim";

      # Apps
      pdf = "zathura";
      img = "imv";
      bt = "bluetui";
      nf = "neofetch";
      c = "clear";

      # Navigation
      cd = "z";

      # Git
      gp = "git push";

      # System
      goodbye = "echo 'Goodbye soldier, you did your best. Rest. Better days are coming for you <3' && sleep 1 && shutdown now";

      # Sway/Wayland
      lock = "swaylock -i ${wallpapers.lock}";
      s = "env WLR_DRM_NO_ATOMIC=1 sway --unsupported-gpu";
      dnd = "killall dunst";

      # Tools
      fz = "fd . | fzf --preview 'bat --style=numbers --color=always {} 2>/dev/null' | xargs -r nvim";
      caido = "caido-cli -l 0.0.0.0:8080";
      pq = "proxychains -q";
    };

    functions = {
      venv = "echo 'layout python' > .envrc && direnv allow";
    };
  };

  # ==========================================================================
  # STARSHIP (using plain-text-symbols style)
  # ==========================================================================
  programs.starship = {
    enable = true;
    settings = {
      character = {
        success_symbol = "[>](bold green)";
        error_symbol = "[x](bold red)";
        vimcmd_symbol = "[<](bold green)";
      };

      git_commit.tag_symbol = " tag ";
      git_status = {
        ahead = ">";
        behind = "<";
        diverged = "<>";
        renamed = "r";
        deleted = "x";
      };

      git_branch.symbol = "git ";
      directory.read_only = " ro";
      status.symbol = "[x](bold red) ";

      # Plain text symbols for common languages
      aws.symbol = "aws ";
      c.symbol = "C ";
      docker_context.symbol = "docker ";
      golang.symbol = "go ";
      java.symbol = "java ";
      lua.symbol = "lua ";
      nodejs.symbol = "node ";
      nix_shell.symbol = "nix ";
      package.symbol = "pkg ";
      php.symbol = "php ";
      python.symbol = "py ";
      rust.symbol = "rs ";
      typescript.symbol = "ts ";
    };
  };

  # ==========================================================================
  # ZOXIDE
  # ==========================================================================
  programs.zoxide.enable = true;
}
