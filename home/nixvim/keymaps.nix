{ ... }:

{
  programs.nixvim.keymaps = [
    # ==========================================================================
    # TELESCOPE
    # ==========================================================================
    { mode = "n"; key = "<Leader>f"; action = "<cmd>Telescope find_files<CR>"; options.silent = true; }
    { mode = "n"; key = "<Leader>F"; action = "<cmd>Telescope live_grep<CR>"; options.silent = true; }

    # ==========================================================================
    # CLIPBOARD
    # ==========================================================================
    { mode = "v"; key = "<Leader>y"; action = "\"+y"; options.silent = true; }
    { mode = "v"; key = "<Leader>x"; action = "\"+x"; options.silent = true; }
    { mode = "v"; key = "<Leader>p"; action = "\"+p"; options.silent = true; }
    { mode = "n"; key = "<Leader>p"; action = "\"+p"; options.silent = true; }

    # ==========================================================================
    # WINDOW NAVIGATION
    # ==========================================================================
    { mode = "n"; key = "<Leader>h"; action = "<C-w>h"; options.silent = true; }
    { mode = "n"; key = "<Leader>j"; action = "<C-w>j"; options.silent = true; }
    { mode = "n"; key = "<Leader>k"; action = "<C-w>k"; options.silent = true; }
    { mode = "n"; key = "<Leader>l"; action = "<C-w>l"; options.silent = true; }

    # ==========================================================================
    # WINDOW SWAPPING
    # ==========================================================================
    { mode = "n"; key = "<Leader>H"; action = "<C-w>H"; options.silent = true; }
    { mode = "n"; key = "<Leader>J"; action = "<C-w>J"; options.silent = true; }
    { mode = "n"; key = "<Leader>K"; action = "<C-w>K"; options.silent = true; }
    { mode = "n"; key = "<Leader>L"; action = "<C-w>L"; options.silent = true; }

    # ==========================================================================
    # FILE OPERATIONS
    # ==========================================================================
    { mode = "n"; key = "<Leader>w"; action = "<cmd>w<CR>"; options.silent = true; }
    { mode = "n"; key = "<Leader>q"; action = "<cmd>q<CR>"; options.silent = true; }
    { mode = "n"; key = "<Leader>Q"; action = "<cmd>q!<CR>"; options.silent = true; }
    { mode = "n"; key = "<Leader>W"; action = "<cmd>wq<CR>"; options.silent = true; }

    # ==========================================================================
    # SELECTION
    # ==========================================================================
    { mode = "n"; key = "<Leader>a"; action = "gg0vG$"; options.silent = true; }
    { mode = "n"; key = "<Leader>e"; action = "$"; options.silent = true; }
    { mode = "v"; key = "<Leader>e"; action = "$h"; options.silent = true; }

    # ==========================================================================
    # NAVIGATION PLUGINS
    # ==========================================================================
    { mode = "n"; key = "<Leader>t"; action = "<cmd>NvimTreeToggle<CR>"; options.silent = true; }
    { mode = "n"; key = "f"; action = "<cmd>lua require('flash').jump()<CR>"; options.silent = true; }
    { mode = "n"; key = "<Leader>o"; action = "<cmd>AerialToggle<CR>"; options.silent = true; }

    # Harpoon
    { mode = "n"; key = "<Leader>="; action.__raw = "function() require('harpoon'):list():add() end"; options.silent = true; }
    { mode = "n"; key = "<Leader>`"; action.__raw = "function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end"; options.silent = true; }
    { mode = "n"; key = "<Tab>"; action.__raw = "function() require('harpoon'):list():next() end"; options.silent = true; }
    { mode = "n"; key = "<S-Tab>"; action.__raw = "function() require('harpoon'):list():prev() end"; options.silent = true; }

    # ==========================================================================
    # LSP
    # ==========================================================================
    { mode = "n"; key = "<Leader>;"; action = "<cmd>lua vim.lsp.buf.format()<CR>"; options.silent = true; }
    { mode = "v"; key = "<Leader>;"; action = "<cmd>lua vim.lsp.buf.format()<CR>"; options.silent = true; }
    { mode = "n"; key = "gd"; action = "<cmd>Telescope lsp_definitions<CR>"; options.silent = true; }
    { mode = "n"; key = "gi"; action = "<cmd>lua vim.lsp.buf.implementation()<CR>"; options.silent = true; }
    { mode = "n"; key = "gh"; action = "<cmd>lua vim.lsp.buf.hover()<CR>"; options.silent = true; }
    { mode = "n"; key = "gR"; action = "<cmd>lua vim.lsp.buf.rename()<CR>"; options.silent = true; }
    { mode = "n"; key = "gr"; action = "<cmd>Telescope lsp_references<CR>"; options.silent = true; }
    { mode = "n"; key = "ge"; action = "<cmd>lua vim.diagnostic.open_float()<CR>"; options.silent = true; }

    # ==========================================================================
    # GIT
    # ==========================================================================
    { mode = "n"; key = "<Leader>g"; action = "<cmd>Neogit<CR>"; options.silent = true; }
    { mode = "n"; key = "<Leader>b"; action = "<cmd>Gitsigns blame_line<CR>"; options.silent = true; }

    # ==========================================================================
    # MISC
    # ==========================================================================
    { mode = "n"; key = "<CR>"; action = "<cmd>noh<CR><CR>"; options.silent = true; }
    { mode = "n"; key = "<A-n>"; action = "<cmd>cnext<CR>"; options.silent = true; }
    { mode = "n"; key = "<A-p>"; action = "<cmd>cprevious<CR>"; options.silent = true; }
  ];
}
