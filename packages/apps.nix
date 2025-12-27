{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Desktop/Wayland
    wev
    wtype
    brightnessctl
    inotify-tools
    gtk-layer-shell
    pamixer
    pulseaudio
    playerctl
    libnotify
    glib

    # Media
    mpv
    vlc
    ffmpeg
    imagemagick
    yt-dlp
    obs-studio

    # Documents
    zathura
    typst
    obsidian

    # Apps
    chromium
    kdePackages.kdenlive
    telegram-desktop
    vesktop
    remmina
    freerdp
  ];
}
