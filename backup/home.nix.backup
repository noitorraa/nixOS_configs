{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./nixvim/nixvim.nix 
  ];

  home.username = "qz7renna";
  home.homeDirectory = "/home/qz7renna";
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    kitty
    obsidian
    steam
    krita
    obs-studio
    discord
    telegram-desktop
    logseq
  ];

  home.file = { };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs.home-manager.enable = true;

  programs.kitty = {
    enable = true;
    themeFile = "AdventureTime";
    font.name = "Fira Code";
    font.size = 18;
    settings = {
      cursor_shape = "beam";
      enable_audio_bell = false;
      confirm_os_window_close = 0;
    };
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "default";
    };
  };

  programs.yazi = {
    enable = true;
    package = (
      pkgs.yazi.override {
        _7zz = pkgs._7zz-rar;
      }
    );
  };
}

# КОНФИГУРАЦИЯ USER-SPACE (HOME MANAGER)
# Управляет:
# - пользовательскими пакетами (home.packages)
# - dotfiles (.bashrc, .config/ и др.)
# - переменными окружения
# - алиасами и функциями shell

# ОСНОВНЫЕ КОМАНДЫ:
#
# Применить изменения для текущего пользователя:
#   home-manager switch
#
# Применить для другого пользователя:
#   home-manager --user <username> switch
#
# Проверить синтаксис конфига (без применения):
#   home-manager build
#
# Сбросить конфигурацию (удалить сгенерированные файлы):
#   home-manager uninstall
#
# После применения:
# - откройте новый терминал для доступа к новым командам
# - перезапустите графическую среду для обновления меню приложений
