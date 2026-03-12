return {
  "Saghen/blink.cmp",
  opts = function(_, opts)
    opts.keymap = vim.tbl_extend("force", opts.keymap or {}, {
      ["<Down>"] = { "insert_next", "fallback" },
      ["<Up>"] = { "insert_prev", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      -- stop accidentally hiding completion
      ["<C-e>"] = false,
    })

    opts.completion = vim.tbl_deep_extend("force", opts.completion or {}, {
      menu = {
        auto_show = true,
      },
    })

    return opts
  end,
}
