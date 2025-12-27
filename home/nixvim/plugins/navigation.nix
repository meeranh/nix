{ ... }:

{
  programs.nixvim.plugins = {
    nvim-tree = {
      enable = true;
      settings.git.enable = true;
      settings.git.ignore = false;
    };

    telescope.enable = true;

    flash = {
      enable = true;
      settings.modes = {
        search.enabled = false;
        char.enabled = false;
      };
    };

    harpoon.enable = true;

    aerial.enable = true;
  };
}
