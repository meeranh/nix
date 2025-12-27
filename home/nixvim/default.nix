{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./keymaps.nix
    ./plugins
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    # ==========================================================================
    # COLORSCHEME
    # ==========================================================================
    colorscheme = "cozy-bear";

    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "cozy-bear-nvim";
        src = inputs.cozy-bear;
      })
    ];

    # ==========================================================================
    # OPTIONS
    # ==========================================================================
    opts = {
      number = true;
      relativenumber = true;
      autoindent = true;
      expandtab = false;
      shiftwidth = 2;
      softtabstop = 2;
      tabstop = 2;
      mouse = "a";
      cmdheight = 0;
      showmode = false;
      lazyredraw = false;
      termguicolors = true;
      linebreak = true;
      ignorecase = true;
      smartcase = true;
    };

    globals.mapleader = " ";

    # ==========================================================================
    # EXTRA LUA
    # ==========================================================================
    extraConfigLua = ''
      -- Copy current file path to clipboard
      vim.keymap.set('n', '<leader>cp', function()
        local filepath = vim.fn.expand('%:p')
        vim.fn.setreg('+', filepath)
      end, { noremap = true, silent = true })

      -- Toggle diagnostics
      vim.keymap.set('n', '<Leader>d', function()
        if vim.diagnostic.is_enabled() then
          vim.diagnostic.enable(false)
          print("Diagnostics disabled")
        else
          vim.diagnostic.enable(true)
          print("Diagnostics enabled")
        end
      end, { noremap = true, silent = true })
    '';
  };
}
