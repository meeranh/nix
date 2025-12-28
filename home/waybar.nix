{ config, pkgs, lib, colors, font, c, templateFile, ... }:

let
  # Create executable scripts in nix store
  playPauseScript = pkgs.writeShellScript "waybar-play-pause"
    (builtins.readFile ../scripts/waybar/play-pause.sh);

  titleScript = pkgs.writeShellScript "waybar-title"
    (builtins.readFile ../scripts/waybar/title.sh);

  batteryScript = pkgs.writeShellScript "waybar-battery"
    (builtins.replaceStrings [ "@fg@" ] [ colors.fg ]
      (builtins.readFile ../scripts/waybar/battery.sh));

  recordingScript = pkgs.writeShellScript "waybar-recording"
    (builtins.replaceStrings [ "@red@" ] [ (c "red") ]
      (builtins.readFile ../scripts/waybar/recording.sh));

in {
  programs.waybar = {
    enable = true;

    style = templateFile ../styles/waybar.css;

    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 35;
      margin-top = 0;
      margin-left = 0;
      margin-right = 0;
      spacing = 7;

      modules-left = [
        "custom/arch" "custom/sep"
        "custom/prev" "custom/play-pause" "custom/next"
        "custom/sep" "custom/title"
      ];
      modules-center = [ "sway/workspaces" ];
      modules-right = [
        "cpu" "custom/sep"
        "memory" "custom/sep"
        "custom/battery" "custom/sep"
        "pulseaudio" "custom/sep"
        "network" "custom/sep"
        "backlight" "custom/sep"
        "clock" "custom/recording"
      ];

      # =====================================================================
      # LEFT MODULES
      # =====================================================================
      "custom/arch" = {
        format = "󰣇 ";
        tooltip = false;
      };

      "custom/sep" = {
        format = "";
        tooltip = false;
      };

      "custom/prev" = {
        format = "{}";
        exec = "echo ''";
        on-click = "playerctl previous";
        tooltip = false;
      };

      "custom/play-pause" = {
        format = " {} ";
        exec = "${playPauseScript}";
        on-click = "playerctl play-pause";
        tooltip = false;
      };

      "custom/next" = {
        format = "{}";
        exec = "echo ''";
        on-click = "playerctl next";
        tooltip = false;
      };

      "custom/title" = {
        format = "{}";
        exec = "${titleScript}";
        tooltip = false;
        max-length = 35;
      };

      # =====================================================================
      # CENTER MODULES
      # =====================================================================
      "sway/workspaces" = {
        format = "{icon}";
        format-icons = {
          focused = "󰮯 ";
          persistent = "󰑊 ";
          default = "󰊠 ";
          urgent = "󰊠 ";
        };
        persistent-workspaces = lib.genAttrs
          (map toString (lib.range 1 10))
          (_: []);
      };

      # =====================================================================
      # RIGHT MODULES
      # =====================================================================
      cpu = {
        format = "<span color='${c "red"}'></span>  {usage}%";
        interval = 1;
        tooltip = false;
      };

      memory = {
        format = "<span color='${c "cyan"}'></span>  {percentage}%";
        interval = 1;
        tooltip = false;
      };

      "custom/battery" = {
        format = "{}";
        exec = "${batteryScript}";
        return-type = "json";
        tooltip = false;
      };

      pulseaudio = {
        format = "<span color='${c "yellow"}'></span>  {volume}%";
        format-muted = "<span color='${c "red"}'></span>  {volume}%";
        on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
        on-scroll-up = "pactl set-sink-volume @DEFAULT_SINK@ +1%";
        on-scroll-down = "pactl set-sink-volume @DEFAULT_SINK@ -1%";
        tooltip = false;
      };

      network = {
        format-wifi = "<span color='${c "blue"}'></span>  {essid}";
        format-disconnected = "<span color='${c "red"}'>󰖪</span>";
        tooltip = false;
      };

      backlight = {
        format = "<span color='${c "red"}'></span>  {percent}%";
        on-click = "sh -c 'pgrep wlsunset && pkill wlsunset || wlsunset -T 5000 -g 0.7 &'";
        on-scroll-up = "brightnessctl set +1%";
        on-scroll-down = "brightnessctl set 1%-";
        tooltip = false;
      };

      clock = {
        format = "{:%I:%M %p}";
        tooltip = false;
      };

      "custom/recording" = {
        exec = "${recordingScript}";
        interval = 1;
        tooltip = false;
      };
    };
  };
}
