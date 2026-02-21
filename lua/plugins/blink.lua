return {
  "Saghen/blink.cmp",
  opts = function(_, opts)
    opts.keymap = vim.tbl_extend("force", opts.keymap or {}, {
      ["<Down>"] = { "select_next", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
    })
    return opts
  end,
}
