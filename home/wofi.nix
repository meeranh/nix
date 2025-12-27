{ config, pkgs, lib, templateFile, ... }:

{
  programs.wofi = {
    enable = true;

    style = templateFile ../styles/wofi.css;

    settings = {
      show = "drun";
      prompt = "Apps";
      layer = "top";
      term = "foot";
      width = "30%";
      height = "50%";
      allow_markup = true;
      allow_images = true;
      image_size = 24;
      hide_scroll = true;
      no_actions = true;
      gtk_dark = true;
      key_expand = "Tab";
      key_exit = "Escape";
    };
  };
}
