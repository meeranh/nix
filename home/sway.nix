{ config, pkgs, lib, colors, wallpapers, c, ... }:

let
  mod = "Mod4";

  screenshot = pkgs.writeShellScript "screenshot"
    (builtins.readFile ../scripts/sway/screenshot.sh);

  recordStart = pkgs.writeShellScript "record-start"
    (builtins.readFile ../scripts/sway/record-start.sh);

  recordStop = pkgs.writeShellScript "record-stop"
    (builtins.readFile ../scripts/sway/record-stop.sh);

  spiralLayout = pkgs.writeScript "spiral-layout"
    (builtins.readFile ../scripts/sway/spiral_layout.py);

in {

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;

    config = {
      modifier = mod;
      terminal = "foot";
      menu = "wofi";

      # =======================================================================
      # STARTUP
      # =======================================================================
      startup = [
        { command = "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP"; }
        { command = "gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'"; always = true; }
        { command = "waybar"; always = true; }
        { command = "${spiralLayout}"; always = true; }
        { command = "dunst"; always = true; }
      ];

      # =======================================================================
      # OUTPUT
      # =======================================================================
      output = {
        eDP-1 = {
          mode = "1920x1080";
          bg = "${wallpapers.desktop} fill";
        };
        "*".bg = "${wallpapers.desktop} fill";
      };

      # =======================================================================
      # INPUT
      # =======================================================================
      input."type:touchpad" = {
        tap = "enabled";
        dwt = "enabled";
      };
      input."type:pointer" = {
        pointer_accel = "1";
      };

      # =======================================================================
      # APPEARANCE
      # =======================================================================
      gaps.inner = 10;
      window.border = 1;

      colors = {
        focused = {
          border = "${c "fg"}99";
          background = "${c "fg"}99";
          text = "${c "fg"}";
          indicator = "${c "fg"}99";
          childBorder = "${c "fg"}99";
        };
        unfocused = {
          border = "${c "bgLight"}";
          background = "${c "bgLight"}";
          text = "${c "fg"}";
          indicator = "${c "bgLight"}";
          childBorder = "${c "bgLight"}";
        };
      };

      # =======================================================================
      # KEYBINDINGS
      # =======================================================================
      keybindings = {
        # Apps
        "${mod}+Return" = "exec foot";
        "${mod}+b" = "exec zen";
        "${mod}+r" = "exec wofi";
        "${mod}+e" = "exec nemo";
        "${mod}+w" = "kill";

        # Lock and exit
        "${mod}+Mod1+l" = "exec swaylock -i ${wallpapers.lock}";
        "${mod}+Shift+semicolon" = "reload";
        "${mod}+x" = "exec swaymsg exit";

        # Waybar toggle
        "${mod}+semicolon" = "exec pkill waybar || waybar &";

        # Brightness
        "XF86MonBrightnessUp" = "exec brightnessctl s +1%";
        "XF86MonBrightnessDown" = "exec brightnessctl s 1%-";

        # Volume
        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume 0 +5%";
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume 0 -5%";
        "${mod}+m" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";

        # Media
        "${mod}+space" = "exec playerctl play-pause";
        "${mod}+n" = "exec playerctl next";
        "${mod}+p" = "exec playerctl previous";

        # Screenshots
        "Print" = "exec ${screenshot}";
        "${mod}+Print" = "exec ${recordStart}";
        "${mod}+Shift+Print" = "exec ${recordStop}";

        # VM
        "${mod}+v" = "exec toggleWin start";
        "${mod}+Shift+v" = "exec toggleWin shutdown";

        # Focus (vim-style)
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";

        # Move windows
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";
        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Down" = "move down";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Right" = "move right";

        # Resize
        "${mod}+Left" = "resize shrink width 20px";
        "${mod}+Right" = "resize grow width 20px";
        "${mod}+Up" = "resize grow height 20px";
        "${mod}+Down" = "resize shrink height 20px";

        # Layout
        "${mod}+f" = "fullscreen";
        "${mod}+t" = "floating toggle";
      }
      # Workspace keybindings (generated)
      // lib.listToAttrs (lib.concatMap (n: let
        key = if n == 10 then "0" else toString n;
      in [
        { name = "${mod}+${key}"; value = "workspace number ${toString n}"; }
        { name = "${mod}+Shift+${key}"; value = "move container to workspace number ${toString n}"; }
      ]) (lib.range 1 10));

      floating.modifier = mod;
      bars = [];
      defaultWorkspace = "workspace number 1";
    };

    extraConfig = ''
      xwayland enable
      default_border pixel 1
    '';
  };
}
