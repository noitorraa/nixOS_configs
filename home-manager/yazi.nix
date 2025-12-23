{ config, lib, pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    package = pkgs.yazi.override {
      _7zz = pkgs._7zz-rar;
    };

    settings = {
      yazi = {
        mgr = {
          show_hidden = true;
          show_icons = true;
          sort_by = "natural";
          sort_dir_first = true;
          sort_reverse = false;
        };
        opener.edit = [{
          run = "'${lib.getExe pkgs.neovim} \"$@\"'";
          block = true;
        }];
        preview = {
          tab_size = 8;
          max_width = 800;
          max_height = 600;
        };
      };
    };

    plugins = {
      "smart-enter" = pkgs.yaziPlugins.smart-enter;
      "chmod" = pkgs.yaziPlugins.chmod;
      "full-border" = pkgs.yaziPlugins.full-border;
      "bookmarks" = pkgs.yaziPlugins.bookmarks;
    };

    # Тема Dracula (тёмная, приятная для глаз)
    theme = {
      mgr = {
        cwd = { fg = "#f8f8f2"; bg = "#44475a"; };
        hovered = { fg = "#282a36"; bg = "#bd93f9"; };
        preview_hovered = { fg = "#282a36"; bg = "#bd93f9"; };
        find_keyword = { fg = "#ffb86c"; bold = true; };
        find_position = { fg = "#8be9fd"; bg = "#44475a"; bold = true; };
        marker = { fg = "#50fa7b"; bold = true; };
        tab_active = { fg = "#282a36"; bg = "#f8f8f2"; };
        tab_inactive = { fg = "#f8f8f2"; bg = "#6272a4"; };
        border = { fg = "#44475a"; };
        current = { fg = "#f8f8f2"; bg = "#6272a4"; };
        selected = { fg = "#f8f8f2"; bg = "#44475a"; };
        hidden = { fg = "#6272a4"; };
        symlink = { fg = "#8be9fd"; };
      };

      status = {
        mode_normal = { fg = "#282a36"; bg = "#f8f8f2"; bold = true; };
        mode_select = { fg = "#282a36"; bg = "#ff79c6"; bold = true; };
        progress_label = { fg = "#f8f8f2"; bold = true; };
        progress_normal = { fg = "#8be9fd"; bg = "#44475a"; };
        progress_error = { fg = "#ff5555"; bg = "#44475a"; };
      };

      input = {
        border = { fg = "#44475a"; };
        title = { fg = "#f8f8f2"; };
        value = { fg = "#f8f8f2"; };
      };

      select = {
        border = { fg = "#44475a"; }; 
        active = { fg = "#f8f8f2"; bg = "#44475a"; };
        inactive = { fg = "#6272a4"; };
      };

      tasks = {
        border = { fg = "#44475a"; };
        title = { fg = "#f8f8f2"; };
      };

      filetype = {
        rules = [
          { mime = "image/*"; fg = "#f1fa8c"; }
          { mime = "video/*"; fg = "#ff79c6"; }
          { mime = "audio/*"; fg = "#bd93f9"; }
          { mime = "application/pdf"; fg = "#ff5555"; }
          { name = "*.rs"; fg = "#ff5555"; }
          { name = "*.py"; fg = "#8be9fd"; }
          { name = "*.js"; fg = "#f1fa8c"; }
          { name = "*.json"; fg = "#50fa7b"; }
          { name = "*.toml"; fg = "#ff79c6"; }
          { name = "*.md"; fg = "#8be9fd"; }
          { name = "*.txt"; fg = "#f8f8f2"; }
        ];
      };

      # Иконки для файлов (Nerd Font)
      icon = {
        rules = [
          { name = "*.rs"; text = ""; fg = "#ff5555"; }
          { name = "*.py"; text = "󰌠"; fg = "#8be9fd"; }
          { name = "*.js"; text = "󰌞"; fg = "#f1fa8c"; }
          { name = "*.json"; text = "󰘦"; fg = "#50fa7b"; }
          { name = "*.toml"; text = "󱓞"; fg = "#ff79c6"; }
          { name = "*.md"; text = "󰓆"; fg = "#8be9fd"; }
          { name = "*.txt"; text = "󰈙"; fg = "#f8f8f2"; }
          { name = "*.zip"; text = "󰗄"; fg = "#ffb86c"; }
          { name = "*.pdf"; text = "󱈙"; fg = "#ff5555"; }
          { name = "*.mp4"; text = "󰈫"; fg = "#ff79c6"; }
          { name = "*.mp3"; text = "󰈣"; fg = "#bd93f9"; }
          { name = "*.png"; text = "󰉏"; fg = "#f1fa8c"; }
          { name = "*.jpg"; text = "󰉏"; fg = "#f1fa8c"; }
        ];
      };
    };

    keymap = {
      mgr.prepend_keymap = [
        { run = "close"; on = [ "<C-q>" ]; desc = "Выйти"; }
        { run = "plugin smart-enter"; on = [ "<Enter>" ]; desc = "Умный Enter"; }
        { run = "plugin bookmarks toggle"; on = [ "b" ]; desc = "Закладки"; }
        { run = "plugin fzf"; on = [ "f" ]; desc = "Fuzzy поиск"; }
        { run = "plugin zoxide"; on = [ "z" ]; desc = "Быстрый переход"; }
        { run = "plugin clipboard copy"; on = [ "y" ]; desc = "Копировать"; }
        { run = "plugin clipboard paste"; on = [ "p" ]; desc = "Вставить"; }
        # Навигация по вкладкам
        { run = "tab_switch 0"; on = [ "1" ]; desc = "Вкладка 1"; }
        { run = "tab_switch 1"; on = [ "2" ]; desc = "Вкладка 2"; }
        { run = "tab_switch 2"; on = [ "3" ]; desc = "Вкладка 3"; }
        { run = "tab_create"; on = [ "T" ]; desc = "Новая вкладка"; }
        { run = "tab_close"; on = [ "X" ]; desc = "Закрыть вкладку"; }
      ];
    };
  };
}
