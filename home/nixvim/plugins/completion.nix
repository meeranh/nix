{ ... }:

{
  programs.nixvim.plugins = {
    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        sources = [
          { name = "nvim_lsp"; }
          { name = "buffer"; }
          { name = "path"; }
          { name = "luasnip"; }
        ];
        window = {
          completion.border = "rounded";
          documentation.border = "rounded";
        };
        mapping = {
          "<M-j>" = "cmp.mapping.select_next_item()";
          "<M-k>" = "cmp.mapping.select_prev_item()";
          "<M-CR>" = "cmp.mapping.close()";
          "<CR>" = "cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })";
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
        };
      };
    };

    luasnip = {
      enable = true;
      fromVscode = [{ }];
    };

    friendly-snippets.enable = true;
  };
}
