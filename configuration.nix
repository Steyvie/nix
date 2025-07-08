{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "steefslaptop";
  # networking.wireless.enable = true;
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  services.xserver.enable = true;
  services.displayManager.ly.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;
  fonts.packages = with pkgs; [ inter fira-code font-awesome ];
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  users.users.steven = {
    isNormalUser = true;
    description = "steven";
    extraGroups = [ "networkmanager" "wheel" ];
  };
  
  /*
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      unstable = import <nix-os-unstable> {
        config = config.nixpkgs.config;
      };
    };
  };
  */
    
  nixpkgs.config.allowUnfree = true;   
  environment.systemPackages = with pkgs; [
    adw-gtk3
    amberol
    # bottles
    firefox
    eduvpn-client
    # gamescope
    gedit
    # ghostty
    git
    # github-desktop
    # gparted
    gradience
    # krita
    # mangohud
    mint-y-icons
    neofetch
    networkmanager-vpnc
    nix-search
    # pika-backup
    # prismlauncher
    # protonvpn-gui
    # rustup
    # signal-desktop
    # steam
    swaybg
    # thunderbird
    tmux
    # vlc
    waybar
    wayfire
    wlr-randr
    wget
    wofi
    xfce.xfce4-docklike-plugin
    xfce.xfce4-whiskermenu-plugin
    # zed-editor
  ];

  programs.wayfire = {
    enable = true;
    plugins = with pkgs.wayfirePlugins; [ wcm firedecor windecor wayfire-plugins-extra ];
  };
  
  services.openssh.enable = true;
  
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["steven"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true; 
  
  system.stateVersion = "25.05";
}

# sudo nixos-update switch --upgrade
# sudo nix-collect-garbage -d
