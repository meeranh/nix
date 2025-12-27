{ config, pkgs, lib, ... }:

let
  gtkDarkConfig = {
    gtk-application-prefer-dark-theme = true;
  };
in {
  gtk = {
    enable = true;

    theme = {
      name = "Tokyonight-Dark";
      package = pkgs.tokyonight-gtk-theme;
    };

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    gtk3.extraConfig = gtkDarkConfig;
    gtk4.extraConfig = gtkDarkConfig;
  };
}
