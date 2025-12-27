{ config, pkgs, lib, inputs, ... }:

let
  # ==========================================================================
  # TOKYO NIGHT COLOR PALETTE
  # ==========================================================================
  colors = {
    bg        = "1a1b26";
    bgLight   = "24283b";
    fg        = "c0caf5";
    white     = "a9b1d6";
    comment   = "565f89";
    red       = "f7768e";
    green     = "9ece6a";
    yellow    = "e0af68";
    blue      = "7aa2f7";
    magenta   = "bb9af7";
    cyan      = "7dcfff";
    orange    = "ff9e64";
    purple    = "9d7cd8";
  };

  # ==========================================================================
  # FONTS
  # ==========================================================================
  font = {
    name = "Iosevka Nerd Font";
    mono = "Iosevka NF";
    size = {
      small  = 15;
      normal = 18;
      large  = 20;
    };
  };

  # ==========================================================================
  # WALLPAPERS
  # ==========================================================================
  wallpapers = {
    desktop = ../wallpapers/img/pinkRose.jpg;
    lock    = ../wallpapers/img/GtfoHD.jpg;
  };

  # ==========================================================================
  # HELPER FUNCTIONS
  # ==========================================================================
  # Add # prefix to color
  c = name: "#${colors.${name}}";

  # Replace template placeholders in a file
  templateFile = file: builtins.replaceStrings
    [ "@bg@" "@bgLight@" "@fg@" "@white@" "@comment@" "@red@" "@green@"
      "@yellow@" "@blue@" "@magenta@" "@cyan@" "@orange@" "@purple@"
      "@font@" "@fontSize@" ]
    [ colors.bg colors.bgLight colors.fg colors.white colors.comment
      colors.red colors.green colors.yellow colors.blue colors.magenta
      colors.cyan colors.orange colors.purple font.name (toString font.size.normal) ]
    (builtins.readFile file);

in {
  imports = [
    ./core.nix
    ./theme.nix
    ./shell.nix
    ./sway.nix
    ./waybar.nix
    ./wofi.nix
    ./foot.nix
    ./dunst.nix
    ./browser.nix
  ];

  # Pass shared config to all modules via _module.args
  _module.args = {
    inherit colors font wallpapers c templateFile;
  };

  home.username = "neo";
  home.homeDirectory = "/home/neo";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
