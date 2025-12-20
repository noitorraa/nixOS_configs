{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # ============ ОСНОВНЫЕ НАСТРОЙКИ NIX ============
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = "25.11";

  # ============ НАСТРОЙКИ ЗАГРУЗЧИКА ============
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # ============ ГРАФИЧЕСКАЯ ПОДСИСТЕМА ============
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ nvidia-vaapi-driver ];
    extraPackages32 = with pkgs.driversi686Linux; [ nvidia-vaapi-driver ];
  };

  # ============ X SERVER И ДИСПЛЕЙНЫЙ МЕНЕДЖЕР ============
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];

    desktopManager.xfce.enable = false;

    xkb = {
      layout = "us,ru";
      options = "grp:alt_shift_toggle";
    };
  };

  programs.niri.enable = true;

  # ============ НАСТРОЙКИ NVIDIA (ГИБРИДНАЯ ГРАФИКА) ============
  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      amdgpuBusId = "PCI:5:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # ============ СИСТЕМНЫЕ ПАКЕТЫ ============
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    htop
    networkmanager
    openssh
    net-tools
    docker
    docker-compose
    lshw
    file
    ffmpeg
    jq
    poppler
    fd
    fzf
    zoxide
    resvg
    mesa-demos
  ];

  # ============ НАСТРОЙКИ ВИРТУАЛИЗАЦИИ ============
  virtualisation.docker = {
    enable = true;
  };

  # ============ СЕТЕВЫЕ НАСТРОЙКИ ============
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # ============ ВРЕМЯ И ЛОКАЛИЗАЦИЯ ============
  time.timeZone = "Asia/Novosibirsk";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # ============ ПОЛЬЗОВАТЕЛИ И ГРУППЫ ============
  users.users.qz7renna = {
    isNormalUser = true;
    description = "qz7renna";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    shell = pkgs.fish;
  };

  # ============ АУДИОСИСТЕМА PIPEWIRE ============
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };
  security.rtkit.enable = true;

  # ============ ДОПОЛНИТЕЛЬНЫЕ СЕРВИСЫ ============
  services.printing.enable = true;
  services.displayManager.sddm.enable = true;

  programs.firefox.enable = true;
  programs.fish.enable = true;
  programs.dms-shell = {
    enable = true;
    systemd = {
      enable = true;
      restartIfChanged = true;
    };

    # Включаем нужные функции
    enableSystemMonitoring = true;
    enableClipboard = true;
    enableVPN = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;
  };
}

# КОНФИГУРАЦИЯ СИСТЕМЫ NIXOS
# Управляет:
# - системными сервисами (sshd, NetworkManager и др.)
# - ядром и загрузчиком
# - глобальными пакетами (environment.systemPackages)
# - настройками сети, пользователей, прав

# ОСНОВНЫЕ КОМАНДЫ:
#
# Применить изменения (пересобрать и активировать систему):
#   sudo nixos-rebuild switch --flake /etc/nixos#my-system
#
# Проверить конфигурацию без применения (создаст /run/current-system):
#   sudo nixos-rebuild build --flake /etc/nixos#my-system
#
# Протестировать конфигурацию в текущем терминале (без перезаписи системы):
#   sudo nixos-rebuild test --flake /etc/nixos#my-system
#
# Перезагрузка (требуется при обновлении ядра/критичных сервисов):
#   sudo reboot
#
# Обновить каналы перед сборкой (обязательно!):
#   nix-channel --update
