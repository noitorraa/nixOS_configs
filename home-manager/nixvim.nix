{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    # Настройки редактора
    opts = {
      number = true;
      relativenumber = true;
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      clipboard = "unnamedplus"; # Ключевая опция для буфера обмена
    };

    plugins = {
      # Существующие плагины
      lualine.enable = true;
      telescope.enable = true;
      treesitter.enable = true;
      web-devicons.enable = true;
      
      # Новые плагины для IDE
      nvim-tree.enable = true; # Файловый менеджер
      gitsigns.enable = true; # Git интеграция
      comment.enable = true; # Умное комментирование
      conform.enable = true; # Автоформатирование
      which-key = {
        enable = true;
      };
      
      # LSP и автодополнение (оставляем как есть)
      lsp = {
        enable = true;
        servers = {
          pyright.enable = true;
          pylsp.enable = true;
	  nixd.enable = true;
          # Можно добавить другие: nixd, lua_ls и т.д.
        };
      };
      
      nvim-cmp = {
        enable = true;
        autoEnableSources = true;
        sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
          # Можно добавить: cmp_luasnip, cmp-git
        ];
      };
    };

    # Если нужны плагины, которых нет прямо в NixVim:
    extraPlugins = with pkgs.vimPlugins; [
      # symbols-outline-nvim
      # nvim-spectre
      # Для их настройки потребуется extraConfigLua
    ];

    # Дополнительная конфигурация на Lua (пример для symbols-outline)
    extraConfigLua = ''
      -- require('symbols-outline').setup()
    '';

    colorschemes.tokyonight = {
      enable = true;
      style = "moon";
    };
    colorscheme = "tokyonight";
  };
}
