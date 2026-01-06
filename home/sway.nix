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

  # Fast workspace switching (Rust binary)
  sway-ws = pkgs.callPackage ../packages/sway-ws {};

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

        # Multi-monitor: throw window to mirror workspace
        "${mod}+Tab" = "exec ${sway-ws}/bin/sway-ws mirror";
      }
      # Workspace keybindings (focus-based: laptop 1-10, HDMI 11-20)
      // lib.listToAttrs (lib.concatMap (n: let
        key = if n == 10 then "0" else toString n;
      in [
        { name = "${mod}+${key}"; value = "exec ${sway-ws}/bin/sway-ws switch ${toString n}"; }
        { name = "${mod}+Shift+${key}"; value = "exec ${sway-ws}/bin/sway-ws move ${toString n}"; }
      ]) (lib.range 1 10));

      floating.modifier = mod;
      bars = [];
      defaultWorkspace = "workspace number 1";
    };

    extraConfig = ''
      xwayland enable
      default_border pixel 1

      # Workspace-to-output assignments
      # Laptop (eDP-1): workspaces 1-10
      # HDMI (HDMI-A-2): workspaces 11-20
      workspace 1 output eDP-1
      workspace 2 output eDP-1
      workspace 3 output eDP-1
      workspace 4 output eDP-1
      workspace 5 output eDP-1
      workspace 6 output eDP-1
      workspace 7 output eDP-1
      workspace 8 output eDP-1
      workspace 9 output eDP-1
      workspace 10 output eDP-1
      workspace 11 output HDMI-A-2 eDP-1
      workspace 12 output HDMI-A-2 eDP-1
      workspace 13 output HDMI-A-2 eDP-1
      workspace 14 output HDMI-A-2 eDP-1
      workspace 15 output HDMI-A-2 eDP-1
      workspace 16 output HDMI-A-2 eDP-1
      workspace 17 output HDMI-A-2 eDP-1
      workspace 18 output HDMI-A-2 eDP-1
      workspace 19 output HDMI-A-2 eDP-1
      workspace 20 output HDMI-A-2 eDP-1
    '';
  };
}
