{ pkgs, ... }:

{
  programs.nixvim.plugins.lsp = {
    enable = true;

    servers = {
      # Python
      pyright.enable = true;

      # Shell
      bashls.enable = true;

      # Lua
      lua_ls = {
        enable = true;
        settings.Lua = {
          runtime.version = "LuaJIT";
          diagnostics.globals = [ "vim" ];
          telemetry.enable = false;
        };
      };

      # JavaScript/TypeScript
      ts_ls.enable = true;

      # JSON
      jsonls.enable = true;

      # PHP
      intelephense = {
        enable = true;
        package = pkgs.nodePackages.intelephense;
      };

      # Nix
      nil_ls.enable = true;
    };
  };
}
