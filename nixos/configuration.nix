# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# To apply changes, run `sudo nixos-rebuild switch`

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set time zone and localization
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  #* NVIDIA
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };
  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true; # `nvidia-settings` cmd
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.markw = {
    isNormalUser = true;
    description = "Mark Wiemer";
    extraGroups = [ "networkmanager" "wheel" "sudo" ];
    packages = with pkgs; [
      #  thunderbird
    ];
  };
  # Allow sudo without password on console
  security.sudo = {
    enable = true;
    extraRules = [{
      users = [ "markw" ];
      commands = [{ command = "ALL"; options = [ "NOPASSWD" ]; }];
    }];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Packages to add or remove
  services.xserver.excludePackages = with pkgs; [
    xterm
  ];
  environment.gnome.excludePackages = with pkgs; [
    epiphany # web browser named "web"
  ];
  environment.systemPackages = with pkgs; [
    # Search https://search.nixos.org/packages
    wget # HTTPS file fetcher
    discord
    protonvpn-gui
    vscodium # VSCode alternative
    git
    git-lfs
    obsidian # Notes
    nodejs_22
    halloy # IRC Client
    nixpkgs-fmt # Nix lang formatter
    fsearch # File search, like voidtools Everything on Windows 
    gnomeExtensions.clipboard-history
    godot_4-mono
    steam-run # Run non-NixOS binaries, ref https://forum.godotengine.org/t/running-exported-project-on-nixos/57619/4
    gimp-with-plugins
    hugo
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-sdk-6.0.428" # for Godot 4.3, ref https://forum.godotengine.org/t/about-when-until-4-4-stable/91714/4
  ];

  # Steam
  programs.steam.enable = true;
  programs.steam.protontricks.enable = true;
  programs.steam.localNetworkGameTransfers.openFirewall = true;
  programs.steam.extraCompatPackages = with pkgs; [
    proton-ge-bin
  ];
  hardware.graphics.enable32Bit = true;

  # GNOME settings
  home-manager.users.markw = { pkgs, ... }: {
    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "24.11";
    # Use `dconf write /` and modify settings in GUI to know what to manually copy here
    dconf.settings = {
      "org/gnome/desktop/peripherals/mouse" = { natural-scroll = true; };
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
      "org/gnome/shell/keybindings" = {
        toggle-message-tray = [ ];
        show-screenshot-ui = [ "F7" ];
      };
      "org/gnome/settings-daemon/plugins/media-keys" = {
        home = [
          "<Super>e"
        ];
      };
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
