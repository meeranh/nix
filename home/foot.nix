{ config, pkgs, lib, colors, font, ... }:

{
  programs.foot = {
    enable = true;

    settings = {
      main.font = "${font.mono}:size=${toString font.size.large}";
      scrollback.lines = 5000;

      colors = {
        # Tokyo Night
        foreground = colors.fg;
        background = colors.bg;

        # Normal colors
        regular0 = colors.bgLight;    # black
        regular1 = colors.red;        # red
        regular2 = colors.green;      # green
        regular3 = colors.yellow;     # yellow
        regular4 = colors.blue;       # blue
        regular5 = colors.magenta;    # magenta
        regular6 = colors.cyan;       # cyan
        regular7 = colors.white;      # white

        # Bright colors
        bright0 = colors.comment;     # bright black
        bright1 = colors.red;         # bright red
        bright2 = colors.green;       # bright green
        bright3 = colors.yellow;      # bright yellow
        bright4 = colors.blue;        # bright blue
        bright5 = colors.magenta;     # bright magenta
        bright6 = colors.cyan;        # bright cyan
        bright7 = colors.fg;          # bright white

        # UI colors
        selection-foreground = colors.fg;
        selection-background = colors.bgLight;
        search-box-no-match = "${colors.bg} ${colors.red}";
        search-box-match = "${colors.fg} ${colors.bgLight}";
        jump-labels = "${colors.bg} ${colors.orange}";
        urls = colors.blue;
        cursor = "${colors.bg} ${colors.fg}";
      };
    };
  };
}
