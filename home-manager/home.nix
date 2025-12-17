{ config, pkgs, ... }:

{

  home.username = "qz7renna";
  home.homeDirectory = "/home/qz7renna";
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "25.11"; 
  home.packages = with pkgs; [
	yazi fd neovim btop kitty obsidian steam krita obs-studio
  ];

home.file = {

};
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
