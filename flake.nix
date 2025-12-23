{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:nix-community/nixvim";

    zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";

    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixvim,
      zapret-discord-youtube,
      dankMaterialShell,
      ...
    }@inputs:
    {
      nixosConfigurations.my-system = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix 
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = false;
            home-manager.useUserPackages = true;
            home-manager.users.qz7renna =
              { config, pkgs, ... }:
              {
                imports = [
                  ./home-manager/home.nix
                  nixvim.homeModules.nixvim
                ];
                _module.args.inputs = inputs;
              };
          }
          zapret-discord-youtube.nixosModules.default
          {
            services.zapret-discord-youtube = {
              enable = true;
              config = "general(ALT)";
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
