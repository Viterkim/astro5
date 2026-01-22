return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        -- core
        "lua-language-server",
        "stylua",
        "tree-sitter-cli",

        -- rust
        "rust-analyzer",
        "codelldb",

        -- typescript / javascript
        "vtsls",
        "js-debug-adapter",
        "eslint_d",
      },
    },
  },
}
