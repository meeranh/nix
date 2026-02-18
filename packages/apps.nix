{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Remote Desktop
    freerdp
    moonlight-qt

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
    poppler-utils

    # Apps
    chromium
    kdePackages.kdenlive
    telegram-desktop
    remmina
  ];
}
