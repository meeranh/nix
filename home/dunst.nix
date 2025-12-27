{ config, pkgs, lib, colors, font, c, ... }:

{
  services.dunst = {
    enable = true;

    settings = {
      global = {
        # Geometry
        width = 350;
        height = 500;
        origin = "top-right";
        offset = "10x10";

        # Appearance
        font = "${font.mono} ${toString font.size.small}";
        frame_width = 1;
        frame_color = "${c "fg"}c0";
        separator_color = "frame";
        padding = 12;
        horizontal_padding = 10;
        text_icon_padding = 5;
        gap_size = 1;

        # Text
        markup = "full";
        format = "<b>%s</b>\\n%b";
        alignment = "center";
        vertical_alignment = "center";
        ellipsize = "middle";

        # Icons
        icon_position = "off";
        enable_recursive_icon_lookup = true;
        icon_theme = "Adwaita";

        # Behavior
        mouse_left_click = "close_current";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "close_all";
      };

      urgency_low = {
        background = "${c "bg"}";
        foreground = "${c "fg"}";
        frame_color = "${c "fg"}";
        timeout = 10;
      };

      urgency_normal = {
        background = "${c "bg"}";
        foreground = "${c "fg"}";
        frame_color = "${c "fg"}";
        timeout = 5;
      };

      urgency_critical = {
        background = "${c "bg"}";
        foreground = "${c "fg"}";
        frame_color = "${c "red"}";
        timeout = 0;
      };
    };
  };
}
