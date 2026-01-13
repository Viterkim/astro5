-- Customize Mason
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        -- core
        "lua-language-server",
        "stylua",
        "tree-sitter-cli",

        -- rust
        "codelldb",

        -- typescript / javascript
        "vtsls",
        "js-debug-adapter",
        "eslint_d",
      },
    },
  },
}
