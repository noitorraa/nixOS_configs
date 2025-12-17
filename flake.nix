{
  description = "My NixOS Configuration with zapret-discord-youtube";

  inputs = {
    # Основной канал Nixpkgs (unstable)
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager для управления пользовательскими пакетами
    home-manager = {
      url = "github:rycee/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Модуль zapret-discord-youtube
    zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";
  };

  outputs = { self, nixpkgs, home-manager, zapret-discord-youtube }: {
    # Конфигурация системы с именем "my-system"
    nixosConfigurations.my-system = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # Базовая конфигурация системы
        ./configuration.nix

        # Интеграция Home Manager
        home-manager.nixosModules.home-manager
        {
          home-manager.useUserPackages = true;
          home-manager.users.qz7renna = ./home-manager/home.nix;
        }

        # Модуль zapret-discord-youtube
        zapret-discord-youtube.nixosModules.default

        # Настройки сервиса zapret
        {
          services.zapret-discord-youtube = {
            enable = true;  # Включаем сервис
            config = "general(ALT)";  # Выбираем конфигурацию 
          };
        }
      ];
    };
  };
}


# FLAKES-КОНФИГУРАЦИЯ (УПРАВЛЕНИЕ ЗАВИСИМОСТЯМИ)
# Управляет:
# - версиями каналов (nixpkgs, home-manager)
# - модулями для NixOS
# - входными данными для сборки

# ОСНОВНЫЕ КОМАНДЫ:
#
# Обновить lock-файл flake (после изменения inputs):
#   nix flake update /etc/nixos
#
# Проверить корректность flake:
#   nix flake check /etc/nixos
#
# Показать все доступные outputs в flake:
#   nix flake show /etc/nixos
#
# Собрать конкретный пакет для проверки:
#   nix build /etc/nixos#packages.x86_64-linux.<имя_пакета>
#
# Перед любыми сборками обновите каналы:
#   nix-channel --update

