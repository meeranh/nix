{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./packages
  ];

  # Bootloader (GRUB for dual-boot with Windows)
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Networking
  networking.hostName = "NeoBox";
  networking.networkmanager.enable = true;

  # Timezone and locale
  time.timeZone = "Asia/Colombo";
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable Flakes
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    warn-dirty = false;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # ==========================================================================
  # DESKTOP: Sway + Wayland
  # ==========================================================================
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      swaylock
      swaybg
      grim
      slurp
      wl-clipboard
      wf-recorder
      wofi
      dunst
      foot
      imv
      wlsunset
      xdg-desktop-portal-wlr
    ];
  };

  # XDG Portal for screen sharing
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Enable XWayland for compatibility
  programs.xwayland.enable = true;

  # ==========================================================================
  # AUDIO: PipeWire
  # ==========================================================================
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # ==========================================================================
  # BLUETOOTH
  # ==========================================================================
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  # ==========================================================================
  # VIRTUALIZATION (Docker only)
  # ==========================================================================
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  # ==========================================================================
  # SERVICES
  # ==========================================================================

  # OpenSSH
  services.openssh.enable = true;

  # Printing (CUPS)
  services.printing.enable = true;

  # Avahi for network discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  # Power management for ThinkPad
  services.thermald.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "powersave";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  # ZRAM swap
  zramSwap.enable = true;

  # Firmware updates
  services.fwupd.enable = true;

  # Locate/plocate
  services.locate = {
    enable = true;
    package = pkgs.plocate;
  };

  # ==========================================================================
  # FONTS
  # ==========================================================================
  fonts = {
    packages = with pkgs; [
      nerd-fonts.iosevka
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf
      font-awesome
      corefonts
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "Iosevka Nerd Font" ];
        sansSerif = [ "Noto Sans" ];
        serif = [ "Noto Serif" ];
      };
    };
  };

  # ==========================================================================
  # USER CONFIGURATION
  # ==========================================================================
  users.users.neo = {
    isNormalUser = true;
    description = "Neo";
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
      "audio"
      "video"
    ];
    shell = pkgs.fish;
  };

  programs.fish = {
    enable = true;
    useBabelfish = true;
  };

  # ==========================================================================
  # MISC
  # ==========================================================================

  # nix-ld for running unpatched binaries
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    zlib
  ];

  environment.variables = {
    NIX_LD_LIBRARY_PATH = "/run/current-system/sw/share/nix-ld/lib";
    NIX_LD = "/run/current-system/sw/share/nix-ld/lib/ld.so";
  };

  # Enable dconf for GTK app settings
  programs.dconf.enable = true;

  # KDE Connect
  programs.kdeconnect.enable = true;

  # OpenGL + Intel VAAPI
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
    ];
  };

  # Disable man cache generation (speeds up builds)
  documentation.man.generateCaches = false;

  # System state version
  system.stateVersion = "24.11";
}
