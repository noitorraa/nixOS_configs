{ pkgs, ... }:
{
   programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    opts = {
      number = true;
      relativenumber = true;
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
    };
    plugins = {
      lualine.enable = true;
      telescope.enable = true;
      treesitter.enable = true;
      web-devicons.enable = true;
      lsp = {
        enable = true;
	servers = {
	 pyright.enable = true;
	 pylsp.enable = true;
	};
       };
       nvim-cmp = {
         enable = true;
	autoEnableSources = true;
	sources = [
	  {name = "nvim_lsp";}
	  {name = "path";}
	  {name = "buffer";}
	];
        };
    };
    colorschemes.tokyonight = {
      enable = true; 
      style = "moon"; 
    };
    colorscheme = "tokyonight";
  };
}
