{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # CLI Tools
    bat
    eza
    fd
    ripgrep
    fzf
    jq
    yq
    zoxide
    starship
    btop
    htop
    glow
    tldr
    trash-cli
    tree
    dua
    tmux
    yazi
    nemo

    # Editors
    neovim
    vim

    # System/Networking
    curl
    wget
    file
    net-tools
    libva-utils
    unzip
    zip
    p7zip
    rar
    nmap
    netcat-openbsd
    socat
    whois
    traceroute
    tcpdump
    bind
    lftp
    httpie
    xh
    hurl

    # Misc
    acpi
    lm_sensors
    exiftool
    powertop
    rclone
    asciinema
    neofetch
    cowsay
    sl
    claude-code
  ];
}
