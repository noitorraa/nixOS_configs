{
  config,
  pkgs,
  lib,
  nixvim,
  ...
}:

{
  home.username = "qz7renna";
  home.homeDirectory = "/home/qz7renna";
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    yazi
    fd
    btop
    kitty
    obsidian
    steam
    krita
    obs-studio
    discord
    telegram-desktop
    nixvim.packages.${pkgs.system}.default
  ];
  home.file = { };
  home.sessionVariables = { };
  programs.home-manager.enable = true;
  programs.kitty = {
    enable = true;
    settings = {
      shell = "${pkgs.fish}/bin/fish";
      window_padding_width = 10;
      scrollback_lines = 10000;
      enable_audio_bell = false;
      cursor = "#e1e2e9";
      cursor_text_color = "#c4c6cf";
      foreground = "#e1e2e9";
      background = "#111318";
      selection_foreground = "#273141";
      selection_background = "#bdc7dc";
      url_color = "#a6c8ff";

      color0 = "#111318";
      color1 = "#e64c46";
      color2 = "#70d66e";
      color3 = "#dbd17b";
      color4 = "#5982ca";
      color5 = "#899ebf";
      color6 = "#a6c8ff";
      color7 = "#abb2bf";
      color8 = "#5c6370";
      color9 = "#e05f5f";
      color10 = "#87e086";
      color11 = "#e8e097";
      color12 = "#b1d6ff";
      color13 = "#4a7da5";
      color14 = "#6677ae";
      color15 = "#ffffff";
    };
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 16;
    };
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
